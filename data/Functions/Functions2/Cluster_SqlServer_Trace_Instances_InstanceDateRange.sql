CREATE FUNCTION [data].[Cluster_SqlServer_Trace_Instances_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Trace_SequenceNumber AS BIGINT
    , @Cluster_SqlServer_Trace_StartTime AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Trace_SequenceNumber], [Cluster_SqlServer_Trace_StartTime]) AS
(
    SELECT [data].[Cluster_SqlServer_Trace_Keys].[Id]
    , [data].[Cluster_SqlServer_Trace_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Trace_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Trace_Keys].[_SequenceNumber] AS [Cluster_SqlServer_Trace_SequenceNumber]
    , [data].[Cluster_SqlServer_Trace_Keys].[_StartTime] AS [Cluster_SqlServer_Trace_StartTime]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Trace_Keys] ON [data].[Cluster_SqlServer_Trace_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_Trace_Keys].[_SequenceNumber] = @Cluster_SqlServer_Trace_SequenceNumber
     AND [data].[Cluster_SqlServer_Trace_Keys].[_StartTime] = @Cluster_SqlServer_Trace_StartTime
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Trace_SequenceNumber]
, [SightedInstances].[Cluster_SqlServer_Trace_StartTime]
, [utils].[TicksToDateTime]([SightedInstances].[Cluster_SqlServer_Trace_StartTime]) AS [Cluster_SqlServer_Trace_StartTime_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ApplicationName] AS [Cluster_SqlServer_Trace_ApplicationName]
, [Leaf].[_DatabaseName] AS [Cluster_SqlServer_Trace_DatabaseName]
, [Leaf].[_HostName] AS [Cluster_SqlServer_Trace_HostName]
, [Leaf].[_LoginName] AS [Cluster_SqlServer_Trace_LoginName]
, [Leaf].[_Spid] AS [Cluster_SqlServer_Trace_Spid]
, [Leaf].[_TextData] AS [Cluster_SqlServer_Trace_TextData]
FROM
 [SightedInstances]
INNER JOIN
 [data].[Cluster_SqlServer_Trace_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]