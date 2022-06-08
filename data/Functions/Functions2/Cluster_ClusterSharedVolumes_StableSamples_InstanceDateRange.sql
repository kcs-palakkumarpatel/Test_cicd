CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_StableSamples_InstanceDateRange]
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
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_MountPoints] AS [Cluster_ClusterSharedVolumes_MountPoints]
, [Leaf].[_TotalBytes] AS [Cluster_ClusterSharedVolumes_TotalBytes]
, [Leaf].[_VolumeLabel] AS [Cluster_ClusterSharedVolumes_VolumeLabel]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_ClusterSharedVolumes_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_ClusterSharedVolumes_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate