﻿CREATE VIEW [data].[AzureManagedInstance_Database_Performance_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_Database_Performance_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Database_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[_ActiveTransactions] AS [AzureManagedInstance_Database_Performance_ActiveTransactions], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[_CumulativeLogBytesFlushed] AS [AzureManagedInstance_Database_Performance_CumulativeLogBytesFlushed], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[_CumulativeLogFlushes] AS [AzureManagedInstance_Database_Performance_CumulativeLogFlushes], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[_CumulativeLogFlushWaits] AS [AzureManagedInstance_Database_Performance_CumulativeLogFlushWaits], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[_CumulativeTransactions] AS [AzureManagedInstance_Database_Performance_CumulativeTransactions], [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_Performance_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name] FROM [data].[AzureManagedInstance_Database_Performance_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_Performance_UnstableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
;