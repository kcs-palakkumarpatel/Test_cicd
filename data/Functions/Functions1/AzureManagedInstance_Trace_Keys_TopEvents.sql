CREATE FUNCTION [data].[AzureManagedInstance_Trace_Keys_TopEvents]
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
FROM [TopInstances]