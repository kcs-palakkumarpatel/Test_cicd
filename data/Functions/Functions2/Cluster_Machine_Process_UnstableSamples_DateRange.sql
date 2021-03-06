CREATE FUNCTION [data].[Cluster_Machine_Process_UnstableSamples_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[Cluster_Machine_Process_Sightings]
    WHERE [data].[Cluster_Machine_Process_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_Machine_Process_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_Process_Id], [Cluster_Machine_Process_StartDate]) AS
(
    SELECT [data].[Cluster_Machine_Process_Keys].[Id]
    , [data].[Cluster_Machine_Process_Keys].[ParentId]
    , [data].[Cluster_Machine_Process_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_Process_Keys].[_Id] AS [Cluster_Machine_Process_Id]
    , [data].[Cluster_Machine_Process_Keys].[_StartDate] AS [Cluster_Machine_Process_StartDate]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_Machine_Process_Keys] ON [data].[Cluster_Machine_Process_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[Id] = [data].[Cluster_Machine_Process_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_Machine_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [SightedInstances].[Cluster_Machine_Process_Id]
, [SightedInstances].[Cluster_Machine_Process_StartDate]
, [utils].[TicksToDateTime]([SightedInstances].[Cluster_Machine_Process_StartDate]) AS [Cluster_Machine_Process_StartDate_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CumulativePrivilegedTime] AS [Cluster_Machine_Process_CumulativePrivilegedTime]
, [Leaf].[_CumulativeUserTime] AS [Cluster_Machine_Process_CumulativeUserTime]
, [Leaf].[_PrivateBytes] AS [Cluster_Machine_Process_PrivateBytes]
, [Leaf].[_VirtualBytes] AS [Cluster_Machine_Process_VirtualBytes]
, [Leaf].[_WorkingSet] AS [Cluster_Machine_Process_WorkingSet]
FROM
 [SightedInstances]
INNER JOIN
(
    -- We partition the date range into n 'bins' and take the last sample in each bin, if available.
    -- We calculate the bin sizes in floating point to handle ranges of less than n ticks, then round up.
    SELECT
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i]    )) AS [PartitionMinDate],
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i] + 1)) AS [PartitionMaxDate]
    FROM [utils].[Nat](@MaxSamples)
    WHERE @MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * [i] < @MaxDate
)
 [PartitionDates] ON 1 = 1
CROSS APPLY
(
    SELECT TOP (@EventCount)
    [CollectionDate]
    , [_CumulativePrivilegedTime]
    , [_CumulativeUserTime]
    , [_PrivateBytes]
    , [_VirtualBytes]
    , [_WorkingSet]
    FROM [data].[Cluster_Machine_Process_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]