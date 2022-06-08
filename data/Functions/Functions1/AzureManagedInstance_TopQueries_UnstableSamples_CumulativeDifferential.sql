CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_UnstableSamples_CumulativeDifferential]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AzureManagedInstance_TopQueries_Sightings]
    WHERE [data].[AzureManagedInstance_TopQueries_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TopQueries_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AzureManagedInstance_TopQueries_Keys].[Id]
, [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
, [data].[AzureManagedInstance_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_TopQueries_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
, [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] AS [AzureManagedInstance_TopQueries_DatabaseName]
, [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] AS [AzureManagedInstance_TopQueries_SqlHandle]
, [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] AS [AzureManagedInstance_TopQueries_StatementEnd]
, [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] AS [AzureManagedInstance_TopQueries_StatementStart]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AzureManagedInstance_TopQueries_ExecutionCount] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_ExecutionCount],0)) AS [AzureManagedInstance_TopQueries_ExecutionCount]
, ([RightLeaf].[AzureManagedInstance_TopQueries_ExecutionTime] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_ExecutionTime],0)) AS [AzureManagedInstance_TopQueries_ExecutionTime]
, ([RightLeaf].[AzureManagedInstance_TopQueries_LogicalReads] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_LogicalReads],0)) AS [AzureManagedInstance_TopQueries_LogicalReads]
, ([RightLeaf].[AzureManagedInstance_TopQueries_LogicalWrites] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_LogicalWrites],0)) AS [AzureManagedInstance_TopQueries_LogicalWrites]
, ([RightLeaf].[AzureManagedInstance_TopQueries_PhysicalReads] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_PhysicalReads],0)) AS [AzureManagedInstance_TopQueries_PhysicalReads]
, ([RightLeaf].[AzureManagedInstance_TopQueries_WorkerTime] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_WorkerTime],0)) AS [AzureManagedInstance_TopQueries_WorkerTime]
FROM [SightedIds]
 INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionCount] AS [AzureManagedInstance_TopQueries_ExecutionCount]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionTime] AS [AzureManagedInstance_TopQueries_ExecutionTime]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalReads] AS [AzureManagedInstance_TopQueries_LogicalReads]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalWrites] AS [AzureManagedInstance_TopQueries_LogicalWrites]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_PhysicalReads] AS [AzureManagedInstance_TopQueries_PhysicalReads]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_WorkerTime] AS [AzureManagedInstance_TopQueries_WorkerTime]
    FROM [data].[AzureManagedInstance_TopQueries_UnstableSamples]
    WHERE [data].[AzureManagedInstance_TopQueries_UnstableSamples].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[Id]
      AND [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionCount] AS [AzureManagedInstance_TopQueries_ExecutionCount]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionTime] AS [AzureManagedInstance_TopQueries_ExecutionTime]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalReads] AS [AzureManagedInstance_TopQueries_LogicalReads]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalWrites] AS [AzureManagedInstance_TopQueries_LogicalWrites]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_PhysicalReads] AS [AzureManagedInstance_TopQueries_PhysicalReads]
    ,  [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_WorkerTime] AS [AzureManagedInstance_TopQueries_WorkerTime]
    FROM [data].[AzureManagedInstance_TopQueries_UnstableSamples]
    WHERE [data].[AzureManagedInstance_TopQueries_UnstableSamples].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[Id]
      AND [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]