﻿CREATE VIEW [data].[AzureManagedInstance_TopQueries_UnstableSamples_View] AS SELECT[data].[AzureManagedInstance_TopQueries_UnstableSamples].[Id] AS [Id], [data].[AzureManagedInstance_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionCount] AS [AzureManagedInstance_TopQueries_ExecutionCount], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_ExecutionTime] AS [AzureManagedInstance_TopQueries_ExecutionTime], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalReads] AS [AzureManagedInstance_TopQueries_LogicalReads], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_LogicalWrites] AS [AzureManagedInstance_TopQueries_LogicalWrites], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_PhysicalReads] AS [AzureManagedInstance_TopQueries_PhysicalReads], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[_WorkerTime] AS [AzureManagedInstance_TopQueries_WorkerTime], [data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_TopQueries_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] AS [AzureManagedInstance_TopQueries_DatabaseName], [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] AS [AzureManagedInstance_TopQueries_SqlHandle], [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] AS [AzureManagedInstance_TopQueries_StatementEnd], [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] AS [AzureManagedInstance_TopQueries_StatementStart] FROM [data].[AzureManagedInstance_TopQueries_UnstableSamples] INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_UnstableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
;