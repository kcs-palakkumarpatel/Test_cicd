CREATE FUNCTION [data].[AzureManagedInstance_Error_Keys_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Error_LogDate], [AzureManagedInstance_Error_SequenceNumber]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [TopEvents].[_LogDate] AS [AzureManagedInstance_Error_LogDate]
    , [TopEvents].[_SequenceNumber] AS [AzureManagedInstance_Error_SequenceNumber]
    FROM [data].[AzureManagedInstance_Keys]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AzureManagedInstance_Error_Keys].[Id]
            , [data].[AzureManagedInstance_Error_Keys].[CollectionDate]
            , [data].[AzureManagedInstance_Error_Keys].[_LogDate]
            , [data].[AzureManagedInstance_Error_Keys].[_SequenceNumber]
            FROM [data].[AzureManagedInstance_Error_Keys]
             WHERE [data].[AzureManagedInstance_Error_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
             AND [data].[AzureManagedInstance_Error_Keys].[_LogDate] >= @MinDate
             AND [data].[AzureManagedInstance_Error_Keys].[_LogDate] <= @MaxDate
            ORDER BY [_LogDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AzureManagedInstance_Name]
, [TopInstances].[AzureManagedInstance_Error_LogDate]
, [utils].[TicksToDateTime]([TopInstances].[AzureManagedInstance_Error_LogDate]) AS [AzureManagedInstance_Error_LogDate_DateTime]
, [TopInstances].[AzureManagedInstance_Error_SequenceNumber]
FROM [TopInstances]