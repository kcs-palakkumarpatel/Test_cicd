﻿CREATE VIEW [config].[Cluster_ClusterSharedVolumes_AlertConfiguration_View] AS SELECT[config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[Id] AS [Id], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_AlertType] AS [Cluster_ClusterSharedVolumes_AlertType], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_SubType] AS [Cluster_ClusterSharedVolumes_SubType], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_Configuration] AS [Cluster_ClusterSharedVolumes_Configuration], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_Enabled] AS [Cluster_ClusterSharedVolumes_Enabled], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_AlertNotification] AS [Cluster_ClusterSharedVolumes_AlertNotification], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_EmailAddress] AS [Cluster_ClusterSharedVolumes_EmailAddress], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_Version] AS [Cluster_ClusterSharedVolumes_Version], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_Comments] AS [Cluster_ClusterSharedVolumes_Comments], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_SlackEnabled] AS [Cluster_ClusterSharedVolumes_SlackEnabled], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_SnmpEnabled] AS [Cluster_ClusterSharedVolumes_SnmpEnabled], [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[_WebhookEnabled] AS [Cluster_ClusterSharedVolumes_WebhookEnabled], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] AS [Cluster_ClusterSharedVolumes_VolumeGuid] FROM [config].[Cluster_ClusterSharedVolumes_AlertConfiguration] INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[Id] = [config].[Cluster_ClusterSharedVolumes_AlertConfiguration].[Id]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
;