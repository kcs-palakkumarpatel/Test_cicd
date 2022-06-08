CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples_CumulativeDifferential]
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
    FROM [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id]
, [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[ParentId]
, [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd]
, [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart]
, [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime],0)) AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime]
, ([RightLeaf].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount],0)) AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount]
FROM [SightedIds]
 INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTime] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime]
    ,  [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTimeCount] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount]
    FROM [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTime] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime]
    ,  [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTimeCount] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount]
    FROM [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]