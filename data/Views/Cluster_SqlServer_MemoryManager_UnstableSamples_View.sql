﻿CREATE VIEW [data].[Cluster_SqlServer_MemoryManager_UnstableSamples_View] AS SELECT[data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_ConnectionMemoryBytes] AS [Cluster_SqlServer_MemoryManager_ConnectionMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_DatabaseCacheMemoryBytes] AS [Cluster_SqlServer_MemoryManager_DatabaseCacheMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_FreeMemoryBytes] AS [Cluster_SqlServer_MemoryManager_FreeMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_LockMemoryBytes] AS [Cluster_SqlServer_MemoryManager_LockMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_LogPoolMemoryBytes] AS [Cluster_SqlServer_MemoryManager_LogPoolMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_MaximumWorkspaceMemoryBytes] AS [Cluster_SqlServer_MemoryManager_MaximumWorkspaceMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_MemoryGrantsPending] AS [Cluster_SqlServer_MemoryManager_MemoryGrantsPending], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_OptimizerMemoryBytes] AS [Cluster_SqlServer_MemoryManager_OptimizerMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_PlanCacheMemoryBytes] AS [Cluster_SqlServer_MemoryManager_PlanCacheMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_ReservedMemoryBytes] AS [Cluster_SqlServer_MemoryManager_ReservedMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_StolenServerMemoryBytes] AS [Cluster_SqlServer_MemoryManager_StolenServerMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_TargetServerMemoryBytes] AS [Cluster_SqlServer_MemoryManager_TargetServerMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_TotalServerMemoryBytes] AS [Cluster_SqlServer_MemoryManager_TotalServerMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[_WorkspaceMemoryBytes] AS [Cluster_SqlServer_MemoryManager_WorkspaceMemoryBytes], [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name] FROM [data].[Cluster_SqlServer_MemoryManager_UnstableSamples] INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_MemoryManager_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;