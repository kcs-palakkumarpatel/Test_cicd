﻿CREATE VIEW [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_AverageCost] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_AverageCost], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_AverageImpact] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_AverageImpact], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_LastUserScan] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserScan], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_LastUserScan]) AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserScan_DateTime], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_LastUserSeek] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserSeek], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_LastUserSeek]) AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserSeek_DateTime], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_UniqueCompiles] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UniqueCompiles], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_UserScans] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UserScans], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[_UserSeeks] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UserSeeks], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name], [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Table_Name], [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] AS [AmazonRdsSqlServer_Database_Table_Schema], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns] FROM [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
;