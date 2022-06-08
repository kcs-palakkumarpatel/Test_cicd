CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples_CumulativeDifferential]
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
    FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Sightings]
    WHERE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id]
, [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[ParentId]
, [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
, [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] AS [AzureManagedInstance_TopQueries_DatabaseName]
, [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] AS [AzureManagedInstance_TopQueries_SqlHandle]
, [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] AS [AzureManagedInstance_TopQueries_StatementEnd]
, [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] AS [AzureManagedInstance_TopQueries_StatementStart]
, [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitType]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AzureManagedInstance_TopQueries_QueryWaitStats_WaitTime] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_QueryWaitStats_WaitTime],0)) AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTime]
, ([RightLeaf].[AzureManagedInstance_TopQueries_QueryWaitStats_WaitTimeCount] - ISNULL([LeftLeaf].[AzureManagedInstance_TopQueries_QueryWaitStats_WaitTimeCount],0)) AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTimeCount]
FROM [SightedIds]
 INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] ON [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[ParentId]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTime] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTime]
    ,  [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTimeCount] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTimeCount]
    FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples]
    WHERE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[Id] = [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id]
      AND [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTime] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTime]
    ,  [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTimeCount] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitTimeCount]
    FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples]
    WHERE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[Id] = [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id]
      AND [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]