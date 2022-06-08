CREATE FUNCTION [data].[AzureManagedInstance_MemoryManager_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Sightings]
    WHERE [data].[AzureManagedInstance_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Keys].[Id]
    , [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [SightedIds].[Id]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ConnectionMemoryBytes] AS [AzureManagedInstance_MemoryManager_ConnectionMemoryBytes]
, [Leaf].[_DatabaseCacheMemoryBytes] AS [AzureManagedInstance_MemoryManager_DatabaseCacheMemoryBytes]
, [Leaf].[_FreeMemoryBytes] AS [AzureManagedInstance_MemoryManager_FreeMemoryBytes]
, [Leaf].[_LockMemoryBytes] AS [AzureManagedInstance_MemoryManager_LockMemoryBytes]
, [Leaf].[_LogPoolMemoryBytes] AS [AzureManagedInstance_MemoryManager_LogPoolMemoryBytes]
, [Leaf].[_MaximumWorkspaceMemoryBytes] AS [AzureManagedInstance_MemoryManager_MaximumWorkspaceMemoryBytes]
, [Leaf].[_MemoryGrantsPending] AS [AzureManagedInstance_MemoryManager_MemoryGrantsPending]
, [Leaf].[_OptimizerMemoryBytes] AS [AzureManagedInstance_MemoryManager_OptimizerMemoryBytes]
, [Leaf].[_PlanCacheMemoryBytes] AS [AzureManagedInstance_MemoryManager_PlanCacheMemoryBytes]
, [Leaf].[_ReservedMemoryBytes] AS [AzureManagedInstance_MemoryManager_ReservedMemoryBytes]
, [Leaf].[_StolenServerMemoryBytes] AS [AzureManagedInstance_MemoryManager_StolenServerMemoryBytes]
, [Leaf].[_TargetServerMemoryBytes] AS [AzureManagedInstance_MemoryManager_TargetServerMemoryBytes]
, [Leaf].[_TotalServerMemoryBytes] AS [AzureManagedInstance_MemoryManager_TotalServerMemoryBytes]
, [Leaf].[_WorkspaceMemoryBytes] AS [AzureManagedInstance_MemoryManager_WorkspaceMemoryBytes]
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
    , [_ConnectionMemoryBytes]
    , [_DatabaseCacheMemoryBytes]
    , [_FreeMemoryBytes]
    , [_LockMemoryBytes]
    , [_LogPoolMemoryBytes]
    , [_MaximumWorkspaceMemoryBytes]
    , [_MemoryGrantsPending]
    , [_OptimizerMemoryBytes]
    , [_PlanCacheMemoryBytes]
    , [_ReservedMemoryBytes]
    , [_StolenServerMemoryBytes]
    , [_TargetServerMemoryBytes]
    , [_TotalServerMemoryBytes]
    , [_WorkspaceMemoryBytes]
    FROM [data].[AzureManagedInstance_MemoryManager_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]