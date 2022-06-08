﻿CREATE VIEW [data].[AzureManagedInstance_ServerWaits_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_SignalWaitTime] AS [AzureManagedInstance_ServerWaits_SignalWaitTime], [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitingTasksCount] AS [AzureManagedInstance_ServerWaits_WaitingTasksCount], [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitTime] AS [AzureManagedInstance_ServerWaits_WaitTime], [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] AS [AzureManagedInstance_ServerWaits_WaitType] FROM [data].[AzureManagedInstance_ServerWaits_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[Id] = [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
;