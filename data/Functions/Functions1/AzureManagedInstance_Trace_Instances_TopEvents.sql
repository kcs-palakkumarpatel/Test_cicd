CREATE FUNCTION [data].[AzureManagedInstance_Trace_Instances_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Trace_SequenceNumber], [AzureManagedInstance_Trace_StartTime]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [TopEvents].[_SequenceNumber] AS [AzureManagedInstance_Trace_SequenceNumber]
    , [TopEvents].[_StartTime] AS [AzureManagedInstance_Trace_StartTime]
    FROM [data].[AzureManagedInstance_Keys]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AzureManagedInstance_Trace_Keys].[Id]
            , [data].[AzureManagedInstance_Trace_Keys].[CollectionDate]
            , [data].[AzureManagedInstance_Trace_Keys].[_SequenceNumber]
            , [data].[AzureManagedInstance_Trace_Keys].[_StartTime]
            FROM [data].[AzureManagedInstance_Trace_Keys]
             WHERE [data].[AzureManagedInstance_Trace_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
             AND [data].[AzureManagedInstance_Trace_Keys].[_StartTime] >= @MinDate
             AND [data].[AzureManagedInstance_Trace_Keys].[_StartTime] <= @MaxDate
            ORDER BY [_StartTime] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AzureManagedInstance_Name]
, [TopInstances].[AzureManagedInstance_Trace_SequenceNumber]
, [TopInstances].[AzureManagedInstance_Trace_StartTime]
, [utils].[TicksToDateTime]([TopInstances].[AzureManagedInstance_Trace_StartTime]) AS [AzureManagedInstance_Trace_StartTime_DateTime]
, [data].[AzureManagedInstance_Trace_Instances].[CollectionDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_Trace_Instances].[CollectionDate]) AS [CollectionDate_DateTime]
, [data].[AzureManagedInstance_Trace_Instances].[_ApplicationName] AS [AzureManagedInstance_Trace_ApplicationName]
, [data].[AzureManagedInstance_Trace_Instances].[_DatabaseName] AS [AzureManagedInstance_Trace_DatabaseName]
, [data].[AzureManagedInstance_Trace_Instances].[_HostName] AS [AzureManagedInstance_Trace_HostName]
, [data].[AzureManagedInstance_Trace_Instances].[_LoginName] AS [AzureManagedInstance_Trace_LoginName]
, [data].[AzureManagedInstance_Trace_Instances].[_Spid] AS [AzureManagedInstance_Trace_Spid]
, [data].[AzureManagedInstance_Trace_Instances].[_TextData] AS [AzureManagedInstance_Trace_TextData]
FROM [TopInstances]
INNER JOIN [data].[AzureManagedInstance_Trace_Instances]
 ON [TopInstances].[Id] = [data].[AzureManagedInstance_Trace_Instances].[Id]