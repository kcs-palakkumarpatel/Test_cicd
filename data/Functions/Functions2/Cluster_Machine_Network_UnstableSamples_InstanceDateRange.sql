CREATE FUNCTION [data].[Cluster_Machine_Network_UnstableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_Machine_Name AS NVARCHAR(450)
    , @Cluster_Machine_Network_Name AS NVARCHAR(450)
    , @Cluster_Machine_Network_SequenceNumber AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_Network_Name], [Cluster_Machine_Network_SequenceNumber]) AS
(
    SELECT [data].[Cluster_Machine_Network_Keys].[Id]
    , [data].[Cluster_Machine_Network_Keys].[ParentId]
    , [data].[Cluster_Machine_Network_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_Network_Keys].[_Name] AS [Cluster_Machine_Network_Name]
    , [data].[Cluster_Machine_Network_Keys].[_SequenceNumber] AS [Cluster_Machine_Network_SequenceNumber]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_Machine_Network_Keys] ON [data].[Cluster_Machine_Network_Keys].[ParentId] = [data].[Cluster_Machine_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_Machine_Keys].[_Name] = @Cluster_Machine_Name
     AND [data].[Cluster_Machine_Network_Keys].[_Name] = @Cluster_Machine_Network_Name
     AND [data].[Cluster_Machine_Network_Keys].[_SequenceNumber] = @Cluster_Machine_Network_SequenceNumber
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [SightedInstances].[Cluster_Machine_Network_Name]
, [SightedInstances].[Cluster_Machine_Network_SequenceNumber]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CumulativeBytesReceived] AS [Cluster_Machine_Network_CumulativeBytesReceived]
, [Leaf].[_CumulativeBytesSent] AS [Cluster_Machine_Network_CumulativeBytesSent]
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
    , [_CumulativeBytesReceived]
    , [_CumulativeBytesSent]
    FROM [data].[Cluster_Machine_Network_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]