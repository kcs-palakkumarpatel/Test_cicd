CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_Activity_Keys_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AzureManagedInstance_Agent_Job_Activity_Sightings]
    WHERE [data].[AzureManagedInstance_Agent_Job_Activity_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Agent_Job_Activity_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Agent_Job_Name], [AzureManagedInstance_Agent_Job_Activity_RunDate]) AS
(
    SELECT [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[Id]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[ParentId]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name]
    , [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[_RunDate] AS [AzureManagedInstance_Agent_Job_Activity_RunDate]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Agent_Job_Activity_Keys] ON [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_Activity_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId]
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