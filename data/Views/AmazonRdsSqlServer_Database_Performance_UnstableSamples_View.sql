﻿CREATE VIEW [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Database_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[_ActiveTransactions] AS [AmazonRdsSqlServer_Database_Performance_ActiveTransactions], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[_CumulativeLogBytesFlushed] AS [AmazonRdsSqlServer_Database_Performance_CumulativeLogBytesFlushed], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[_CumulativeLogFlushes] AS [AmazonRdsSqlServer_Database_Performance_CumulativeLogFlushes], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[_CumulativeLogFlushWaits] AS [AmazonRdsSqlServer_Database_Performance_CumulativeLogFlushWaits], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[_CumulativeTransactions] AS [AmazonRdsSqlServer_Database_Performance_CumulativeTransactions], [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name] FROM [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
;