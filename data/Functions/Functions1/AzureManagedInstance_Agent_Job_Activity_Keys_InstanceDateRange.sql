CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_Activity_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Agent_Job_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Agent_Job_Activity_RunDate AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Agent_Job_Name], [AzureManagedInstance_Agent_Job_Activity_RunDate]) AS
(
    SELECT [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[Id]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[ParentId]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[_RunDate] AS [AzureManagedInstance_Agent_Job_Activity_RunDate]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Agent_Job_Activity_Keys] ON [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[ParentId] = [data].[AzureManagedInstance_Agent_Job_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] = @AzureManagedInstance_Agent_Job_Name
     AND [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[_RunDate] = @AzureManagedInstance_Agent_Job_Activity_RunDate
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Agent_Job_Name]
, [SightedInstances].[AzureManagedInstance_Agent_Job_Activity_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_Agent_Job_Activity_RunDate]) AS [AzureManagedInstance_Agent_Job_Activity_RunDate_DateTime]
FROM
 [SightedInstances]