CREATE FUNCTION [data].[AmazonRdsSqlServer_Services_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Services_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Services_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Services_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Services_ServiceName]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Services_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Services_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Services_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Services_Keys].[_ServiceName] AS [AmazonRdsSqlServer_Services_ServiceName]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Services_Keys] ON [data].[AmazonRdsSqlServer_Services_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Services_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Services_ServiceName]
FROM
 [SightedInstances]