CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_ConfigurationOptions_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[_Name] AS [AmazonRdsSqlServer_Database_ConfigurationOptions_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys] ON [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_ConfigurationOptions_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_ConfigurationOptions_Name]
FROM
 [SightedInstances]