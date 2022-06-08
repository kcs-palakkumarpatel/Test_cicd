﻿CREATE VIEW [data].[AzureManagedInstance_Services_StableSamples_View] AS SELECT[data].[AzureManagedInstance_Services_StableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Services_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Services_StableSamples].[_ServiceState] AS [AzureManagedInstance_Services_ServiceState], [data].[AzureManagedInstance_Services_StableSamples].[_Startup] AS [AzureManagedInstance_Services_Startup], [data].[AzureManagedInstance_Services_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Services_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_Services_Keys].[_ServiceName] AS [AzureManagedInstance_Services_ServiceName] FROM [data].[AzureManagedInstance_Services_StableSamples] INNER JOIN [data].[AzureManagedInstance_Services_Keys] ON [data].[AzureManagedInstance_Services_Keys].[Id] = [data].[AzureManagedInstance_Services_StableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Services_Keys].[ParentId]
;