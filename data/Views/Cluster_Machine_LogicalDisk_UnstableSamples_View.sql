﻿CREATE VIEW [data].[Cluster_Machine_LogicalDisk_UnstableSamples_View] AS SELECT[data].[Cluster_Machine_LogicalDisk_UnstableSamples].[Id] AS [Id], [data].[Cluster_Machine_LogicalDisk_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeIdleTime] AS [Cluster_Machine_LogicalDisk_CumulativeIdleTime], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeReadBytes] AS [Cluster_Machine_LogicalDisk_CumulativeReadBytes], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeReads] AS [Cluster_Machine_LogicalDisk_CumulativeReads], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeReadTime] AS [Cluster_Machine_LogicalDisk_CumulativeReadTime], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeWriteBytes] AS [Cluster_Machine_LogicalDisk_CumulativeWriteBytes], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeWrites] AS [Cluster_Machine_LogicalDisk_CumulativeWrites], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[_CumulativeWriteTime] AS [Cluster_Machine_LogicalDisk_CumulativeWriteTime], [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_Machine_LogicalDisk_UnstableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name], [data].[Cluster_Machine_LogicalDisk_Keys].[_Name] AS [Cluster_Machine_LogicalDisk_Name] FROM [data].[Cluster_Machine_LogicalDisk_UnstableSamples] INNER JOIN [data].[Cluster_Machine_LogicalDisk_Keys] ON [data].[Cluster_Machine_LogicalDisk_Keys].[Id] = [data].[Cluster_Machine_LogicalDisk_UnstableSamples].[Id]
 INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[Id] = [data].[Cluster_Machine_LogicalDisk_Keys].[ParentId]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_Machine_Keys].[ParentId]
;