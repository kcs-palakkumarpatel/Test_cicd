﻿CREATE VIEW [data].[AzureManagedInstance_Database_CustomMetric_StableSamples_View] AS SELECT[data].[AzureManagedInstance_Database_CustomMetric_StableSamples].[Id] AS [Id], [data].[AzureManagedInstance_Database_CustomMetric_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AzureManagedInstance_Database_CustomMetric_StableSamples].[_ErrorMessage] AS [AzureManagedInstance_Database_CustomMetric_ErrorMessage], [data].[AzureManagedInstance_Database_CustomMetric_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_CustomMetric_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name], [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name], [data].[AzureManagedInstance_Database_CustomMetric_Keys].[_MetricId] AS [AzureManagedInstance_Database_CustomMetric_MetricId] FROM [data].[AzureManagedInstance_Database_CustomMetric_StableSamples] INNER JOIN [data].[AzureManagedInstance_Database_CustomMetric_Keys] ON [data].[AzureManagedInstance_Database_CustomMetric_Keys].[Id] = [data].[AzureManagedInstance_Database_CustomMetric_StableSamples].[Id]
 INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_CustomMetric_Keys].[ParentId]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
;