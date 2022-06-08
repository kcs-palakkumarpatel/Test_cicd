﻿CREATE VIEW [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTime] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime], [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[_WaitTimeCount] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount], [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName], [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle], [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd], [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart], [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType] FROM [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId]
;