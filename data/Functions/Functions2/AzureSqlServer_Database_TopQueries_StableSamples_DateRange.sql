CREATE FUNCTION [data].[AzureSqlServer_Database_TopQueries_StableSamples_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AzureSqlServer_Database_TopQueries_Sightings]
    WHERE [data].[AzureSqlServer_Database_TopQueries_Sightings].[SightingDate] >= @MinDate AND [data].[AzureSqlServer_Database_TopQueries_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureSqlServer_Name], [AzureSqlServer_Database_Name], [AzureSqlServer_Database_TopQueries_DatabaseName], [AzureSqlServer_Database_TopQueries_SqlHandle], [AzureSqlServer_Database_TopQueries_StatementEnd], [AzureSqlServer_Database_TopQueries_StatementStart]) AS
(
    SELECT [data].[AzureSqlServer_Database_TopQueries_Keys].[Id]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[ParentId]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureSqlServer_Keys].[_Name] AS [AzureSqlServer_Name]
    , [data].[AzureSqlServer_Database_Keys].[_Name] AS [AzureSqlServer_Database_Name]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[_DatabaseName] AS [AzureSqlServer_Database_TopQueries_DatabaseName]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[_SqlHandle] AS [AzureSqlServer_Database_TopQueries_SqlHandle]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[_StatementEnd] AS [AzureSqlServer_Database_TopQueries_StatementEnd]
    , [data].[AzureSqlServer_Database_TopQueries_Keys].[_StatementStart] AS [AzureSqlServer_Database_TopQueries_StatementStart]
    FROM [SightedIds]
     INNER JOIN [data].[AzureSqlServer_Database_TopQueries_Keys] ON [data].[AzureSqlServer_Database_TopQueries_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[Id] = [data].[AzureSqlServer_Database_TopQueries_Keys].[ParentId]
     INNER JOIN [data].[AzureSqlServer_Keys] ON [data].[AzureSqlServer_Keys].[Id] = [data].[AzureSqlServer_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureSqlServer_Name]
, [SightedInstances].[AzureSqlServer_Database_Name]
, [SightedInstances].[AzureSqlServer_Database_TopQueries_DatabaseName]
, [SightedInstances].[AzureSqlServer_Database_TopQueries_SqlHandle]
, [SightedInstances].[AzureSqlServer_Database_TopQueries_StatementEnd]
, [SightedInstances].[AzureSqlServer_Database_TopQueries_StatementStart]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CreateDate] AS [AzureSqlServer_Database_TopQueries_CreateDate]
, [utils].[TicksToDateTime]([Leaf].[_CreateDate]) AS [AzureSqlServer_Database_TopQueries_CreateDate_DateTime]
, [Leaf].[_PlanHandle] AS [AzureSqlServer_Database_TopQueries_PlanHandle]
, [Leaf].[_QueryHash] AS [AzureSqlServer_Database_TopQueries_QueryHash]
, [Leaf].[_QueryPlanHash] AS [AzureSqlServer_Database_TopQueries_QueryPlanHash]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureSqlServer_Database_TopQueries_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureSqlServer_Database_TopQueries_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate