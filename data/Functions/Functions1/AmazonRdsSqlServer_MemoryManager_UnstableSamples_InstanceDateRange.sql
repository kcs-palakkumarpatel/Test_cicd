CREATE FUNCTION [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    FROM [data].[AmazonRdsSqlServer_Keys]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ConnectionMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_ConnectionMemoryBytes]
, [Leaf].[_DatabaseCacheMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_DatabaseCacheMemoryBytes]
, [Leaf].[_FreeMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_FreeMemoryBytes]
, [Leaf].[_LockMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_LockMemoryBytes]
, [Leaf].[_LogPoolMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_LogPoolMemoryBytes]
, [Leaf].[_MaximumWorkspaceMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_MaximumWorkspaceMemoryBytes]
, [Leaf].[_MemoryGrantsPending] AS [AmazonRdsSqlServer_MemoryManager_MemoryGrantsPending]
, [Leaf].[_OptimizerMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_OptimizerMemoryBytes]
, [Leaf].[_PlanCacheMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_PlanCacheMemoryBytes]
, [Leaf].[_ReservedMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_ReservedMemoryBytes]
, [Leaf].[_StolenServerMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_StolenServerMemoryBytes]
, [Leaf].[_TargetServerMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_TargetServerMemoryBytes]
, [Leaf].[_TotalServerMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_TotalServerMemoryBytes]
, [Leaf].[_WorkspaceMemoryBytes] AS [AmazonRdsSqlServer_MemoryManager_WorkspaceMemoryBytes]
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
    FROM [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]