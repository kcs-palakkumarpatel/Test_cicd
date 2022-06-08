CREATE FUNCTION [data].[AmazonRdsSqlServer_Trace_Instances_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Trace_SequenceNumber], [AmazonRdsSqlServer_Trace_StartTime]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [TopEvents].[_SequenceNumber] AS [AmazonRdsSqlServer_Trace_SequenceNumber]
    , [TopEvents].[_StartTime] AS [AmazonRdsSqlServer_Trace_StartTime]
    FROM [data].[AmazonRdsSqlServer_Keys]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AmazonRdsSqlServer_Trace_Keys].[Id]
            , [data].[AmazonRdsSqlServer_Trace_Keys].[CollectionDate]
            , [data].[AmazonRdsSqlServer_Trace_Keys].[_SequenceNumber]
            , [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime]
            FROM [data].[AmazonRdsSqlServer_Trace_Keys]
             WHERE [data].[AmazonRdsSqlServer_Trace_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
             AND [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] >= @MinDate
             AND [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] <= @MaxDate
            ORDER BY [_StartTime] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AmazonRdsSqlServer_Name]
, [TopInstances].[AmazonRdsSqlServer_Trace_SequenceNumber]
, [TopInstances].[AmazonRdsSqlServer_Trace_StartTime]
, [utils].[TicksToDateTime]([TopInstances].[AmazonRdsSqlServer_Trace_StartTime]) AS [AmazonRdsSqlServer_Trace_StartTime_DateTime]
, [data].[AmazonRdsSqlServer_Trace_Instances].[CollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Trace_Instances].[CollectionDate]) AS [CollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_ApplicationName] AS [AmazonRdsSqlServer_Trace_ApplicationName]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_DatabaseName] AS [AmazonRdsSqlServer_Trace_DatabaseName]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_HostName] AS [AmazonRdsSqlServer_Trace_HostName]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_LoginName] AS [AmazonRdsSqlServer_Trace_LoginName]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_Spid] AS [AmazonRdsSqlServer_Trace_Spid]
, [data].[AmazonRdsSqlServer_Trace_Instances].[_TextData] AS [AmazonRdsSqlServer_Trace_TextData]
FROM [TopInstances]
INNER JOIN [data].[AmazonRdsSqlServer_Trace_Instances]
 ON [TopInstances].[Id] = [data].[AmazonRdsSqlServer_Trace_Instances].[Id]