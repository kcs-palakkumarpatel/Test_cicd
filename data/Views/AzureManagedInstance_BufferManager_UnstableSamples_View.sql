﻿CREATE VIEW [data].[AzureManagedInstance_BufferManager_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_BufferManager_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_BufferManager_UnstableSamples].[_FreeListStalls] AS [AzureManagedInstance_BufferManager_FreeListStalls], [data].[AzureManagedInstance_BufferManager_UnstableSamples].[_PageLifeExpectancy] AS [AzureManagedInstance_BufferManager_PageLifeExpectancy], [data].[AzureManagedInstance_BufferManager_UnstableSamples].[_PageReads] AS [AzureManagedInstance_BufferManager_PageReads], [data].[AzureManagedInstance_BufferManager_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_BufferManager_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name] FROM [data].[AzureManagedInstance_BufferManager_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_BufferManager_UnstableSamples].[Id]
;