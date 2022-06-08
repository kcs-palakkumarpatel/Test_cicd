﻿CREATE VIEW [data].[AzureManagedInstance_TempDB_Files_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_TempDB_Files_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[_FreeBytes] AS [AzureManagedInstance_TempDB_Files_FreeBytes], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[_InternalBytes] AS [AzureManagedInstance_TempDB_Files_InternalBytes], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[_MixedBytes] AS [AzureManagedInstance_TempDB_Files_MixedBytes], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[_UserBytes] AS [AzureManagedInstance_TempDB_Files_UserBytes], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[_VersionStoreBytes] AS [AzureManagedInstance_TempDB_Files_VersionStoreBytes], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] AS [AzureManagedInstance_TempDB_Files_FileName] FROM [data].[AzureManagedInstance_TempDB_Files_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_TempDB_Files_Keys] ON [data].[AzureManagedInstance_TempDB_Files_Keys].[Id] = [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId]
;