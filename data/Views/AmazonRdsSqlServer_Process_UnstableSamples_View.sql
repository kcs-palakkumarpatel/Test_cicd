﻿CREATE VIEW [data].[AmazonRdsSqlServer_Process_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Process_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Process_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[_PercentageCpuUsed] AS [AmazonRdsSqlServer_Process_PercentageCpuUsed], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[_PercentageMemoryUsed] AS [AmazonRdsSqlServer_Process_PercentageMemoryUsed], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[_PrivateSetKilobytes] AS [AmazonRdsSqlServer_Process_PrivateSetKilobytes], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[_ShareableSetKilobytes] AS [AmazonRdsSqlServer_Process_ShareableSetKilobytes], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[_VirtualKilobytes] AS [AmazonRdsSqlServer_Process_VirtualKilobytes], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Process_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_Process_Keys].[_Name] AS [AmazonRdsSqlServer_Process_Name], [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] AS [AmazonRdsSqlServer_Process_Pid] FROM [data].[AmazonRdsSqlServer_Process_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[Id] = [data].[AmazonRdsSqlServer_Process_UnstableSamples].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Process_Keys].[ParentId]
;