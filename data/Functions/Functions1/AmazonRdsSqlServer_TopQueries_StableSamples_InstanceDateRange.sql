CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_StableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_DatabaseName AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_SqlHandle AS VARBINARY(900)
    , @AmazonRdsSqlServer_TopQueries_StatementEnd AS BIGINT
    , @AmazonRdsSqlServer_TopQueries_StatementStart AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TopQueries_DatabaseName], [AmazonRdsSqlServer_TopQueries_SqlHandle], [AmazonRdsSqlServer_TopQueries_StatementEnd], [AmazonRdsSqlServer_TopQueries_StatementStart]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] = @AmazonRdsSqlServer_TopQueries_DatabaseName
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] = @AmazonRdsSqlServer_TopQueries_SqlHandle
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] = @AmazonRdsSqlServer_TopQueries_StatementEnd
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] = @AmazonRdsSqlServer_TopQueries_StatementStart
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_DatabaseName]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_SqlHandle]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_StatementEnd]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_StatementStart]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CreateDate] AS [AmazonRdsSqlServer_TopQueries_CreateDate]
, [utils].[TicksToDateTime]([Leaf].[_CreateDate]) AS [AmazonRdsSqlServer_TopQueries_CreateDate_DateTime]
, [Leaf].[_PlanHandle] AS [AmazonRdsSqlServer_TopQueries_PlanHandle]
, [Leaf].[_QueryHash] AS [AmazonRdsSqlServer_TopQueries_QueryHash]
, [Leaf].[_QueryPlanHash] AS [AmazonRdsSqlServer_TopQueries_QueryPlanHash]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AmazonRdsSqlServer_TopQueries_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AmazonRdsSqlServer_TopQueries_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate