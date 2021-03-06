CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_Keys_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_ClusterSharedVolumes_VolumeGuid AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_ClusterSharedVolumes_VolumeGuid]) AS
(
    SELECT [data].[Cluster_ClusterSharedVolumes_Keys].[Id]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] AS [Cluster_ClusterSharedVolumes_VolumeGuid]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] = @Cluster_ClusterSharedVolumes_VolumeGuid
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