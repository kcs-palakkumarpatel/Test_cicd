CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Objects_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TempDB_Objects_TempTableName]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[_TempTableName] AS [AmazonRdsSqlServer_TempDB_Objects_TempTableName]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Objects_Keys] ON [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TempDB_Objects_TempTableName]
FROM
 [SightedInstances]