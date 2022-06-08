CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_Keys_DateRange]
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
    FROM [data].[Cluster_ClusterSharedVolumes_Sightings]
    WHERE [data].[Cluster_ClusterSharedVolumes_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_ClusterSharedVolumes_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_ClusterSharedVolumes_VolumeGuid]) AS
(
    SELECT [data].[Cluster_ClusterSharedVolumes_Keys].[Id]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] AS [Cluster_ClusterSharedVolumes_VolumeGuid]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_ClusterSharedVolumes_VolumeGuid]
FROM
 [SightedInstances]