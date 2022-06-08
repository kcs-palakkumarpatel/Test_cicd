CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples_CumulativeDifferential]
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
    FROM [data].[AmazonRdsSqlServer_TopQueries_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TopQueries_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_TopQueries_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_ExecutionCount] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_ExecutionCount],0)) AS [AmazonRdsSqlServer_TopQueries_ExecutionCount]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_ExecutionTime] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_ExecutionTime],0)) AS [AmazonRdsSqlServer_TopQueries_ExecutionTime]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_LogicalReads] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_LogicalReads],0)) AS [AmazonRdsSqlServer_TopQueries_LogicalReads]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_LogicalWrites] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_LogicalWrites],0)) AS [AmazonRdsSqlServer_TopQueries_LogicalWrites]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_PhysicalReads] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_PhysicalReads],0)) AS [AmazonRdsSqlServer_TopQueries_PhysicalReads]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_WorkerTime] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_WorkerTime],0)) AS [AmazonRdsSqlServer_TopQueries_WorkerTime]
FROM [SightedIds]
 INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_ExecutionCount] AS [AmazonRdsSqlServer_TopQueries_ExecutionCount]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_ExecutionTime] AS [AmazonRdsSqlServer_TopQueries_ExecutionTime]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_LogicalReads] AS [AmazonRdsSqlServer_TopQueries_LogicalReads]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_LogicalWrites] AS [AmazonRdsSqlServer_TopQueries_LogicalWrites]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_PhysicalReads] AS [AmazonRdsSqlServer_TopQueries_PhysicalReads]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_WorkerTime] AS [AmazonRdsSqlServer_TopQueries_WorkerTime]
    FROM [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_ExecutionCount] AS [AmazonRdsSqlServer_TopQueries_ExecutionCount]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_ExecutionTime] AS [AmazonRdsSqlServer_TopQueries_ExecutionTime]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_LogicalReads] AS [AmazonRdsSqlServer_TopQueries_LogicalReads]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_LogicalWrites] AS [AmazonRdsSqlServer_TopQueries_LogicalWrites]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_PhysicalReads] AS [AmazonRdsSqlServer_TopQueries_PhysicalReads]
    ,  [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[_WorkerTime] AS [AmazonRdsSqlServer_TopQueries_WorkerTime]
    FROM [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]