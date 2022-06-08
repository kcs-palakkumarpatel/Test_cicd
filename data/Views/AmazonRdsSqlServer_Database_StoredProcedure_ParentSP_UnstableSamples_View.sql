﻿CREATE VIEW [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples_View] AS SELECT[data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[Id] AS [Id], [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[_LastExecutionTime] AS [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_LastExecutionTime], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[_LastExecutionTime]) AS [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_LastExecutionTime_DateTime], [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name], [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[_Name] AS [AmazonRdsSqlServer_Database_StoredProcedure_Name], [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] AS [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent], [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] AS [AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Name] FROM [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples] INNER JOIN [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_UnstableSamples].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys] ON [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[ParentId]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
;