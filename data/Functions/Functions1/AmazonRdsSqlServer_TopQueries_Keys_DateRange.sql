CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_TopQueries_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TopQueries_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TopQueries_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TopQueries_DatabaseName], [AmazonRdsSqlServer_TopQueries_SqlHandle], [AmazonRdsSqlServer_TopQueries_StatementEnd], [AmazonRdsSqlServer_TopQueries_StatementStart]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
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
FROM
 [SightedInstances]