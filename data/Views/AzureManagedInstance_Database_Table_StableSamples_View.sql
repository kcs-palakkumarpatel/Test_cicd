﻿CREATE VIEW [data].[AzureManagedInstance_Database_Table_StableSamples_View] AS SELECT[data].[AzureManagedInstance_Database_Table_StableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Database_Table_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Database_Table_StableSamples].[_CreateDate] AS [AzureManagedInstance_Database_Table_CreateDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_Table_StableSamples].[_CreateDate]) AS [AzureManagedInstance_Database_Table_CreateDate_DateTime], [data].[AzureManagedInstance_Database_Table_StableSamples].[_ModifyDate] AS [AzureManagedInstance_Database_Table_ModifyDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_Table_StableSamples].[_ModifyDate]) AS [AzureManagedInstance_Database_Table_ModifyDate_DateTime], [data].[AzureManagedInstance_Database_Table_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_Table_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name], [data].[AzureManagedInstance_Database_Table_Keys].[_Name] AS [AzureManagedInstance_Database_Table_Name], [data].[AzureManagedInstance_Database_Table_Keys].[_Schema] AS [AzureManagedInstance_Database_Table_Schema] FROM [data].[AzureManagedInstance_Database_Table_StableSamples] INNER JOIN [data].[AzureManagedInstance_Database_Table_Keys] ON [data].[AzureManagedInstance_Database_Table_Keys].[Id] = [data].[AzureManagedInstance_Database_Table_StableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_Table_Keys].[ParentId]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
;