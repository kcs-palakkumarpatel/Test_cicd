﻿CREATE VIEW [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples_View] AS SELECT[data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[_Active] AS [Cluster_SqlServer_Network_TcpEndpoint_Active], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[_DynamicPorts] AS [Cluster_SqlServer_Network_TcpEndpoint_DynamicPorts], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[_Enabled] AS [Cluster_SqlServer_Network_TcpEndpoint_Enabled], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[_IpAddress] AS [Cluster_SqlServer_Network_TcpEndpoint_IpAddress], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[_Port] AS [Cluster_SqlServer_Network_TcpEndpoint_Port], [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[_EndpointId] AS [Cluster_SqlServer_Network_TcpEndpoint_EndpointId] FROM [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples] INNER JOIN [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys] ON [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[Id] = [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;