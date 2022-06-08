﻿CREATE VIEW [data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples].[_TotalBytes] AS [AmazonRdsSqlServer_Memory_Capacity_TotalBytes], [data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name] FROM [data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Memory_Capacity_StableSamples].[Id]
;