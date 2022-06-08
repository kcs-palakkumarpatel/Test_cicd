﻿CREATE VIEW [data].[AmazonRdsSqlServer_Trace_Instances_View] AS SELECT[data].[AmazonRdsSqlServer_Trace_Instances].[Id] AS [Id], [data].[AmazonRdsSqlServer_Trace_Keys].[CollectionDate] AS [IdCollectionDate], [data].[AmazonRdsSqlServer_Trace_Instances].[_ApplicationName] AS [AmazonRdsSqlServer_Trace_ApplicationName], [data].[AmazonRdsSqlServer_Trace_Instances].[_DatabaseName] AS [AmazonRdsSqlServer_Trace_DatabaseName], [data].[AmazonRdsSqlServer_Trace_Instances].[_HostName] AS [AmazonRdsSqlServer_Trace_HostName], [data].[AmazonRdsSqlServer_Trace_Instances].[_LoginName] AS [AmazonRdsSqlServer_Trace_LoginName], [data].[AmazonRdsSqlServer_Trace_Instances].[_Spid] AS [AmazonRdsSqlServer_Trace_Spid], [data].[AmazonRdsSqlServer_Trace_Instances].[_TextData] AS [AmazonRdsSqlServer_Trace_TextData], [data].[AmazonRdsSqlServer_Trace_Instances].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Trace_Instances].[CollectionDate]) AS [CollectionDate_DateTime], [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name], [data].[AmazonRdsSqlServer_Trace_Keys].[_SequenceNumber] AS [AmazonRdsSqlServer_Trace_SequenceNumber], [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] AS [AmazonRdsSqlServer_Trace_StartTime], [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime]) AS [AmazonRdsSqlServer_Trace_StartTime_DateTime] FROM [data].[AmazonRdsSqlServer_Trace_Instances] INNER JOIN [data].[AmazonRdsSqlServer_Trace_Keys] ON [data].[AmazonRdsSqlServer_Trace_Keys].[Id] = [data].[AmazonRdsSqlServer_Trace_Instances].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Trace_Keys].[ParentId]
;