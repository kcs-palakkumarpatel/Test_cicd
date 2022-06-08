CREATE FUNCTION [data].[AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Sightings]
    WHERE [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_StoredProc_Name], [AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent], [AzureManagedInstance_Database_StoredProc_ParentSP_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[Id]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_StoredProc_Keys].[_Name] AS [AzureManagedInstance_Database_StoredProc_Name]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_DatabaseNameParent] AS [AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_Name] AS [AzureManagedInstance_Database_StoredProc_ParentSP_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys] ON [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Database_StoredProc_Keys] ON [data].[AzureManagedInstance_Database_StoredProc_Keys].[Id] = [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_StoredProc_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_Name]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_ParentSP_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_LastExecutionTime] AS [AzureManagedInstance_Database_StoredProc_ParentSP_LastExecutionTime]
, [utils].[TicksToDateTime]([Leaf].[_LastExecutionTime]) AS [AzureManagedInstance_Database_StoredProc_ParentSP_LastExecutionTime_DateTime]
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
    , [_LastExecutionTime]
    FROM [data].[AzureManagedInstance_Database_StoredProc_ParentSP_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]