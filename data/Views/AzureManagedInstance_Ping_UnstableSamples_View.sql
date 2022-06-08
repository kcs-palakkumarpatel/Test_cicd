﻿CREATE VIEW [data].[AzureManagedInstance_Ping_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_Ping_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Ping_UnstableSamples].[_RoundtripTime] AS [AzureManagedInstance_Ping_RoundtripTime], [data].[AzureManagedInstance_Ping_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Ping_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name] FROM [data].[AzureManagedInstance_Ping_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Ping_UnstableSamples].[Id]
;