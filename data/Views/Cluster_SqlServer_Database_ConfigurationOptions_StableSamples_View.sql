﻿CREATE VIEW [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples_View] AS SELECT[data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Database_ConfigurationOptions_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[_Type] AS [Cluster_SqlServer_Database_ConfigurationOptions_Type], [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[_Value] AS [Cluster_SqlServer_Database_ConfigurationOptions_Value], [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name], [data].[Cluster_SqlServer_Database_ConfigurationOptions_Keys].[_Name] AS [Cluster_SqlServer_Database_ConfigurationOptions_Name] FROM [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples] INNER JOIN [data].[Cluster_SqlServer_Database_ConfigurationOptions_Keys] ON [data].[Cluster_SqlServer_Database_ConfigurationOptions_Keys].[Id] = [data].[Cluster_SqlServer_Database_ConfigurationOptions_StableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[Id] = [data].[Cluster_SqlServer_Database_ConfigurationOptions_Keys].[ParentId]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Database_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;