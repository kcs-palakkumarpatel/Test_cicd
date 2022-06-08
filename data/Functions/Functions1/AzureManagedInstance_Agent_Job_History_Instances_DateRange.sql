CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_History_Instances_DateRange]
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
    FROM [data].[AzureManagedInstance_Agent_Job_History_Sightings]
    WHERE [data].[AzureManagedInstance_Agent_Job_History_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Agent_Job_History_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Agent_Job_Name], [AzureManagedInstance_Agent_Job_History_Id], [AzureManagedInstance_Agent_Job_History_RunDate]) AS
(
    SELECT [data].[AzureManagedInstance_Agent_Job_History_Keys].[Id]
    , [data].[AzureManagedInstance_Agent_Job_History_Keys].[ParentId]
    , [data].[AzureManagedInstance_Agent_Job_History_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name]
    , [data].[AzureManagedInstance_Agent_Job_History_Keys].[_Id] AS [AzureManagedInstance_Agent_Job_History_Id]
    , [data].[AzureManagedInstance_Agent_Job_History_Keys].[_RunDate] AS [AzureManagedInstance_Agent_Job_History_RunDate]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Agent_Job_History_Keys] ON [data].[AzureManagedInstance_Agent_Job_History_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_History_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Agent_Job_Name]
, [SightedInstances].[AzureManagedInstance_Agent_Job_History_Id]
, [SightedInstances].[AzureManagedInstance_Agent_Job_History_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_Agent_Job_History_RunDate]) AS [AzureManagedInstance_Agent_Job_History_RunDate_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Message] AS [AzureManagedInstance_Agent_Job_History_Message]
, [Leaf].[_RunDuration] AS [AzureManagedInstance_Agent_Job_History_RunDuration]
, [Leaf].[_RunStatus] AS [AzureManagedInstance_Agent_Job_History_RunStatus]
, [Leaf].[_SqlMessageId] AS [AzureManagedInstance_Agent_Job_History_SqlMessageId]
, [Leaf].[_SqlSeverity] AS [AzureManagedInstance_Agent_Job_History_SqlSeverity]
, [Leaf].[_StepID] AS [AzureManagedInstance_Agent_Job_History_StepID]
, [Leaf].[_StepMessage] AS [AzureManagedInstance_Agent_Job_History_StepMessage]
, [Leaf].[_StepName] AS [AzureManagedInstance_Agent_Job_History_StepName]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_Agent_Job_History_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]