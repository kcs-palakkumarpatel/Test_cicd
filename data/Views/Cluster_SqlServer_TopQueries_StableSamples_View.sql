﻿CREATE VIEW [data].[Cluster_SqlServer_TopQueries_StableSamples_View] AS SELECT[data].[Cluster_SqlServer_TopQueries_StableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_TopQueries_StableSamples].[_CreateDate] AS [Cluster_SqlServer_TopQueries_CreateDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_TopQueries_StableSamples].[_CreateDate]) AS [Cluster_SqlServer_TopQueries_CreateDate_DateTime], [data].[Cluster_SqlServer_TopQueries_StableSamples].[_PlanHandle] AS [Cluster_SqlServer_TopQueries_PlanHandle], [data].[Cluster_SqlServer_TopQueries_StableSamples].[_QueryHash] AS [Cluster_SqlServer_TopQueries_QueryHash], [data].[Cluster_SqlServer_TopQueries_StableSamples].[_QueryPlanHash] AS [Cluster_SqlServer_TopQueries_QueryPlanHash], [data].[Cluster_SqlServer_TopQueries_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_TopQueries_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_TopQueries_Keys].[_DatabaseName] AS [Cluster_SqlServer_TopQueries_DatabaseName], [data].[Cluster_SqlServer_TopQueries_Keys].[_SqlHandle] AS [Cluster_SqlServer_TopQueries_SqlHandle], [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementEnd] AS [Cluster_SqlServer_TopQueries_StatementEnd], [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementStart] AS [Cluster_SqlServer_TopQueries_StatementStart] FROM [data].[Cluster_SqlServer_TopQueries_StableSamples] INNER JOIN [data].[Cluster_SqlServer_TopQueries_Keys] ON [data].[Cluster_SqlServer_TopQueries_Keys].[Id] = [data].[Cluster_SqlServer_TopQueries_StableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TopQueries_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;