CREATE FUNCTION [data].[Cluster_SqlServer_TempDB_Objects_Keys_DateRange]
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
    FROM [data].[Cluster_SqlServer_TempDB_Objects_Sightings]
    WHERE [data].[Cluster_SqlServer_TempDB_Objects_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_TempDB_Objects_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_TempDB_Objects_TempTableName]) AS
(
    SELECT [data].[Cluster_SqlServer_TempDB_Objects_Keys].[Id]
    , [data].[Cluster_SqlServer_TempDB_Objects_Keys].[ParentId]
    , [data].[Cluster_SqlServer_TempDB_Objects_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_TempDB_Objects_Keys].[_TempTableName] AS [Cluster_SqlServer_TempDB_Objects_TempTableName]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_TempDB_Objects_Keys] ON [data].[Cluster_SqlServer_TempDB_Objects_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TempDB_Objects_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_TempDB_Objects_TempTableName]
FROM
 [SightedInstances]