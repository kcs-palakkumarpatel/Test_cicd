CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_StableSamples_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_ClusterSharedVolumes_VolumeGuid AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_ClusterSharedVolumes_StableSamples].[Id], [data].[Cluster_ClusterSharedVolumes_StableSamples].[CollectionDate]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_ClusterSharedVolumes_StableSamples] ON [data].[Cluster_ClusterSharedVolumes_StableSamples].[Id] = [data].[Cluster_ClusterSharedVolumes_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_ClusterSharedVolumes_VolumeGuid IS NULL OR [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] = @Cluster_ClusterSharedVolumes_VolumeGuid)