CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlProcess_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_SqlProcess_Sightings]
    WHERE [data].[AmazonRdsSqlServer_SqlProcess_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_SqlProcess_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_SqlProcess_LoginTime], [AmazonRdsSqlServer_SqlProcess_SessionId]) AS
(
    SELECT [data].[AmazonRdsSqlServer_SqlProcess_Keys].[Id]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] AS [AmazonRdsSqlServer_SqlProcess_LoginTime]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] AS [AmazonRdsSqlServer_SqlProcess_SessionId]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_Keys] ON [data].[AmazonRdsSqlServer_SqlProcess_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]) AS [AmazonRdsSqlServer_SqlProcess_LoginTime_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_SessionId]
FROM
 [SightedInstances]