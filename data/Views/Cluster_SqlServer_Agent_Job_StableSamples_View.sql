﻿CREATE VIEW [data].[Cluster_SqlServer_Agent_Job_StableSamples_View] AS SELECT[data].[Cluster_SqlServer_Agent_Job_StableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_CategoryName] AS [Cluster_SqlServer_Agent_Job_CategoryName], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_DatabaseNameOrNone] AS [Cluster_SqlServer_Agent_Job_DatabaseNameOrNone], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_DateModified] AS [Cluster_SqlServer_Agent_Job_DateModified], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Agent_Job_StableSamples].[_DateModified]) AS [Cluster_SqlServer_Agent_Job_DateModified_DateTime], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_Description] AS [Cluster_SqlServer_Agent_Job_Description], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_Enabled] AS [Cluster_SqlServer_Agent_Job_Enabled], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_JobId] AS [Cluster_SqlServer_Agent_Job_JobId], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_Owner] AS [Cluster_SqlServer_Agent_Job_Owner], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_OwnerSid] AS [Cluster_SqlServer_Agent_Job_OwnerSid], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[_VersionNumber] AS [Cluster_SqlServer_Agent_Job_VersionNumber], [data].[Cluster_SqlServer_Agent_Job_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Agent_Job_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] AS [Cluster_SqlServer_Agent_Job_Name] FROM [data].[Cluster_SqlServer_Agent_Job_StableSamples] INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Keys].[Id] = [data].[Cluster_SqlServer_Agent_Job_StableSamples].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Agent_Job_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;