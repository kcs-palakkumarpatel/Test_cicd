﻿CREATE VIEW [data].[AmazonRdsSqlServer_SqlText_Instances_View] AS SELECT[data].[AmazonRdsSqlServer_SqlText_Instances].[Id] AS [Id], [data].[AmazonRdsSqlServer_SqlText_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_SqlText_Instances].[_SqlText] AS [AmazonRdsSqlServer_SqlText_SqlText], [data].[AmazonRdsSqlServer_SqlText_Instances].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_SqlText_Instances].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_SqlText_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_SqlText_SqlHandle] FROM [data].[AmazonRdsSqlServer_SqlText_Instances] INNER JOIN [data].[AmazonRdsSqlServer_SqlText_Keys] ON [data].[AmazonRdsSqlServer_SqlText_Keys].[Id] = [data].[AmazonRdsSqlServer_SqlText_Instances].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId]
;