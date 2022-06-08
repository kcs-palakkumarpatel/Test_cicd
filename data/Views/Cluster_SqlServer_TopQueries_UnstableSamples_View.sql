﻿CREATE VIEW [data].[Cluster_SqlServer_TopQueries_UnstableSamples_View] AS SELECT[data].[Cluster_SqlServer_TopQueries_UnstableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_ExecutionCount] AS [Cluster_SqlServer_TopQueries_ExecutionCount], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_ExecutionTime] AS [Cluster_SqlServer_TopQueries_ExecutionTime], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_LogicalReads] AS [Cluster_SqlServer_TopQueries_LogicalReads], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_LogicalWrites] AS [Cluster_SqlServer_TopQueries_LogicalWrites], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_PhysicalReads] AS [Cluster_SqlServer_TopQueries_PhysicalReads], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[_WorkerTime] AS [Cluster_SqlServer_TopQueries_WorkerTime], [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_TopQueries_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_TopQueries_Keys].[_DatabaseName] AS [Cluster_SqlServer_TopQueries_DatabaseName], [data].[Cluster_SqlServer_TopQueries_Keys].[_SqlHandle] AS [Cluster_SqlServer_TopQueries_SqlHandle], [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementEnd] AS [Cluster_SqlServer_TopQueries_StatementEnd], [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementStart] AS [Cluster_SqlServer_TopQueries_StatementStart] FROM [data].[Cluster_SqlServer_TopQueries_UnstableSamples] INNER JOIN [data].[Cluster_SqlServer_TopQueries_Keys] ON [data].[Cluster_SqlServer_TopQueries_Keys].[Id] = [data].[Cluster_SqlServer_TopQueries_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TopQueries_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;