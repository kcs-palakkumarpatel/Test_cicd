CREATE FUNCTION [data].[AmazonRdsSqlServer_Trace_Instances_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Trace_SequenceNumber AS BIGINT
    , @AmazonRdsSqlServer_Trace_StartTime AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Trace_SequenceNumber], [AmazonRdsSqlServer_Trace_StartTime]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Trace_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Trace_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Trace_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Trace_Keys].[_SequenceNumber] AS [AmazonRdsSqlServer_Trace_SequenceNumber]
    , [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] AS [AmazonRdsSqlServer_Trace_StartTime]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Trace_Keys] ON [data].[AmazonRdsSqlServer_Trace_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Trace_Keys].[_SequenceNumber] = @AmazonRdsSqlServer_Trace_SequenceNumber
     AND [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] = @AmazonRdsSqlServer_Trace_StartTime
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Trace_SequenceNumber]
, [SightedInstances].[AmazonRdsSqlServer_Trace_StartTime]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Trace_StartTime]) AS [AmazonRdsSqlServer_Trace_StartTime_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ApplicationName] AS [AmazonRdsSqlServer_Trace_ApplicationName]
, [Leaf].[_DatabaseName] AS [AmazonRdsSqlServer_Trace_DatabaseName]
, [Leaf].[_HostName] AS [AmazonRdsSqlServer_Trace_HostName]
, [Leaf].[_LoginName] AS [AmazonRdsSqlServer_Trace_LoginName]
, [Leaf].[_Spid] AS [AmazonRdsSqlServer_Trace_Spid]
, [Leaf].[_TextData] AS [AmazonRdsSqlServer_Trace_TextData]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_Trace_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]