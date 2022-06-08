﻿CREATE VIEW [data].[AzureManagedInstance_Resources_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_Resources_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Resources_UnstableSamples].[_CumulativeIdleTime] AS [AzureManagedInstance_Resources_CumulativeIdleTime], [data].[AzureManagedInstance_Resources_UnstableSamples].[_CumulativeReadBytes] AS [AzureManagedInstance_Resources_CumulativeReadBytes], [data].[AzureManagedInstance_Resources_UnstableSamples].[_CumulativeTransfers] AS [AzureManagedInstance_Resources_CumulativeTransfers], [data].[AzureManagedInstance_Resources_UnstableSamples].[_CumulativeWriteBytes] AS [AzureManagedInstance_Resources_CumulativeWriteBytes], [data].[AzureManagedInstance_Resources_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Resources_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name] FROM [data].[AzureManagedInstance_Resources_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Resources_UnstableSamples].[Id]
;