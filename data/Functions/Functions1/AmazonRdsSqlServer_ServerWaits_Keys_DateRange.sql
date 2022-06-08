CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_ServerWaits_Sightings]
    WHERE [data].[AmazonRdsSqlServer_ServerWaits_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_ServerWaits_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_ServerWaits_WaitType]) AS
(
    SELECT [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[_WaitType] AS [AmazonRdsSqlServer_ServerWaits_WaitType]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_ServerWaits_Keys] ON [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_ServerWaits_WaitType]
FROM
 [SightedInstances]