﻿CREATE VIEW [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples_View] AS SELECT[data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[_NextRunDate] AS [AzureManagedInstance_Agent_Job_Schedule_NextRunDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[_NextRunDate]) AS [AzureManagedInstance_Agent_Job_Schedule_NextRunDate_DateTime], [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name] FROM [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples] INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_Schedule_StableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId]
;