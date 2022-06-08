﻿CREATE VIEW [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances_View] AS SELECT[data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances].[Id] AS [Id], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances].[_PlanHandle] AS [Cluster_SqlServer_Database_Table_MissingIndex_Plans_PlanHandle], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name], [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name], [data].[Cluster_SqlServer_Database_Table_Keys].[_Name] AS [Cluster_SqlServer_Database_Table_Name], [data].[Cluster_SqlServer_Database_Table_Keys].[_Schema] AS [Cluster_SqlServer_Database_Table_Schema], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] AS [Cluster_SqlServer_Database_Table_MissingIndex_EqualityColumns], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] AS [Cluster_SqlServer_Database_Table_MissingIndex_IncludedColumns], [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] AS [Cluster_SqlServer_Database_Table_MissingIndex_InequalityColumns] FROM [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances] INNER JOIN [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys] ON [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[Id] = [data].[Cluster_SqlServer_Database_Table_MissingIndex_Plans_Instances].[Id]
 INNER JOIN [data].[Cluster_SqlServer_Database_Table_Keys] ON [data].[Cluster_SqlServer_Database_Table_Keys].[Id] = [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys].[ParentId]
 INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[Id] = [data].[Cluster_SqlServer_Database_Table_Keys].[ParentId]
 INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Database_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;