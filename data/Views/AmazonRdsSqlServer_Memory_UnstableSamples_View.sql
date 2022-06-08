﻿CREATE VIEW [data].[AmazonRdsSqlServer_Memory_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Memory_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Memory_UnstableSamples].[_FreeBytes] AS [AmazonRdsSqlServer_Memory_FreeBytes], [data].[AmazonRdsSqlServer_Memory_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Memory_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name] FROM [data].[AmazonRdsSqlServer_Memory_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Memory_UnstableSamples].[Id]
;