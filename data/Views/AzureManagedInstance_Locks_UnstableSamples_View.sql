﻿CREATE VIEW [data].[AzureManagedInstance_Locks_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_Locks_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Locks_UnstableSamples].[_CumulativeDeadlocks] AS [AzureManagedInstance_Locks_CumulativeDeadlocks], [data].[AzureManagedInstance_Locks_UnstableSamples].[_CumulativeLockTimeouts] AS [AzureManagedInstance_Locks_CumulativeLockTimeouts], [data].[AzureManagedInstance_Locks_UnstableSamples].[_CumulativeLockWaits] AS [AzureManagedInstance_Locks_CumulativeLockWaits], [data].[AzureManagedInstance_Locks_UnstableSamples].[_CumulativeLockWaitTime] AS [AzureManagedInstance_Locks_CumulativeLockWaitTime], [data].[AzureManagedInstance_Locks_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Locks_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name] FROM [data].[AzureManagedInstance_Locks_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Locks_UnstableSamples].[Id]
;