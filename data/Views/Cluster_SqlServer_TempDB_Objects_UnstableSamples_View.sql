﻿CREATE VIEW [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples_View] AS SELECT[data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_TempDB_Objects_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[_ReservedBytes] AS [Cluster_SqlServer_TempDB_Objects_ReservedBytes], [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[_RowCount] AS [Cluster_SqlServer_TempDB_Objects_RowCount], [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[_UsedBytes] AS [Cluster_SqlServer_TempDB_Objects_UsedBytes], [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_TempDB_Objects_Keys].[_TempTableName] AS [Cluster_SqlServer_TempDB_Objects_TempTableName] FROM [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples] INNER JOIN [data].[Cluster_SqlServer_TempDB_Objects_Keys] ON [data].[Cluster_SqlServer_TempDB_Objects_Keys].[Id] = [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TempDB_Objects_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;