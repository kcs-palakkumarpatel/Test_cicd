CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_History_Keys_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Agent_Job_Name], [AzureManagedInstance_Agent_Job_History_Id], [AzureManagedInstance_Agent_Job_History_RunDate]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name]
    , [TopEvents].[_Id] AS [AzureManagedInstance_Agent_Job_History_Id]
    , [TopEvents].[_RunDate] AS [AzureManagedInstance_Agent_Job_History_RunDate]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AzureManagedInstance_Agent_Job_History_Keys].[Id]
            , [data].[AzureManagedInstance_Agent_Job_History_Keys].[CollectionDate]
            , [data].[AzureManagedInstance_Agent_Job_History_Keys].[_Id]
            , [data].[AzureManagedInstance_Agent_Job_History_Keys].[_RunDate]
            FROM [data].[AzureManagedInstance_Agent_Job_History_Keys]
             WHERE [data].[AzureManagedInstance_Agent_Job_History_Keys].[ParentId] = [data].[AzureManagedInstance_Agent_Job_Keys].[Id]
             AND [data].[AzureManagedInstance_Agent_Job_History_Keys].[_RunDate] >= @MinDate
             AND [data].[AzureManagedInstance_Agent_Job_History_Keys].[_RunDate] <= @MaxDate
            ORDER BY [_RunDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AzureManagedInstance_Name]
, [TopInstances].[AzureManagedInstance_Agent_Job_Name]
, [TopInstances].[AzureManagedInstance_Agent_Job_History_Id]
, [TopInstances].[AzureManagedInstance_Agent_Job_History_RunDate]
, [utils].[TicksToDateTime]([TopInstances].[AzureManagedInstance_Agent_Job_History_RunDate]) AS [AzureManagedInstance_Agent_Job_History_RunDate_DateTime]
FROM [TopInstances]