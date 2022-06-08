﻿CREATE VIEW [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples_View] AS SELECT[data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[_FreeBytes] AS [Cluster_SqlServer_TempDB_Distribution_FreeBytes], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[_InternalBytes] AS [Cluster_SqlServer_TempDB_Distribution_InternalBytes], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[_MixedExtentBytes] AS [Cluster_SqlServer_TempDB_Distribution_MixedExtentBytes], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[_UserObjectBytes] AS [Cluster_SqlServer_TempDB_Distribution_UserObjectBytes], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[_VersionBytes] AS [Cluster_SqlServer_TempDB_Distribution_VersionBytes], [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name] FROM [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples] INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TempDB_Distribution_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;