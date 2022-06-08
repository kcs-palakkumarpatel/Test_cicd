CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlText_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_SqlText_Sightings]
    WHERE [data].[AmazonRdsSqlServer_SqlText_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_SqlText_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_SqlText_SqlHandle]) AS
(
    SELECT [data].[AmazonRdsSqlServer_SqlText_Keys].[Id]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_SqlText_SqlHandle]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_SqlText_Keys] ON [data].[AmazonRdsSqlServer_SqlText_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_SqlText_SqlHandle]
FROM
 [SightedInstances]