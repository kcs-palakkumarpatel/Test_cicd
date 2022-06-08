﻿CREATE VIEW [data].[AmazonRdsSqlServer_StableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_StableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_StableSamples].[_IsReachable] AS [AmazonRdsSqlServer_IsReachable], [data].[AmazonRdsSqlServer_StableSamples].[_IsReadyForDataCollection] AS [AmazonRdsSqlServer_IsReadyForDataCollection], [data].[AmazonRdsSqlServer_StableSamples].[_MonitoredEntityState] AS [AmazonRdsSqlServer_MonitoredEntityState], [data].[AmazonRdsSqlServer_StableSamples].[_MonitoringStatusCategory] AS [AmazonRdsSqlServer_MonitoringStatusCategory], [data].[AmazonRdsSqlServer_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name] FROM [data].[AmazonRdsSqlServer_StableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_StableSamples].[Id]
;