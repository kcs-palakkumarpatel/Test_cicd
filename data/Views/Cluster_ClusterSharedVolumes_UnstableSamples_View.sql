﻿CREATE VIEW [data].[Cluster_ClusterSharedVolumes_UnstableSamples_View] AS SELECT[data].[Cluster_ClusterSharedVolumes_UnstableSamples].[Id] AS [Id], [data].[Cluster_ClusterSharedVolumes_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_ClusterSharedVolumes_UnstableSamples].[_FreeBytes] AS [Cluster_ClusterSharedVolumes_FreeBytes], [data].[Cluster_ClusterSharedVolumes_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_ClusterSharedVolumes_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] AS [Cluster_ClusterSharedVolumes_VolumeGuid] FROM [data].[Cluster_ClusterSharedVolumes_UnstableSamples] INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[Id] = [data].[Cluster_ClusterSharedVolumes_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
;