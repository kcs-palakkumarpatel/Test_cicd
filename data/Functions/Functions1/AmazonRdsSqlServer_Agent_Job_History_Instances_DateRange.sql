CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_History_Instances_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Agent_Job_History_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name], [AmazonRdsSqlServer_Agent_Job_History_Id], [AmazonRdsSqlServer_Agent_Job_History_RunDate]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_Id] AS [AmazonRdsSqlServer_Agent_Job_History_Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] AS [AmazonRdsSqlServer_Agent_Job_History_RunDate]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_History_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_History_Id]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_History_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Agent_Job_History_RunDate]) AS [AmazonRdsSqlServer_Agent_Job_History_RunDate_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Message] AS [AmazonRdsSqlServer_Agent_Job_History_Message]
, [Leaf].[_RunDuration] AS [AmazonRdsSqlServer_Agent_Job_History_RunDuration]
, [Leaf].[_RunStatus] AS [AmazonRdsSqlServer_Agent_Job_History_RunStatus]
, [Leaf].[_SqlMessageId] AS [AmazonRdsSqlServer_Agent_Job_History_SqlMessageId]
, [Leaf].[_SqlSeverity] AS [AmazonRdsSqlServer_Agent_Job_History_SqlSeverity]
, [Leaf].[_StepID] AS [AmazonRdsSqlServer_Agent_Job_History_StepID]
, [Leaf].[_StepMessage] AS [AmazonRdsSqlServer_Agent_Job_History_StepMessage]
, [Leaf].[_StepName] AS [AmazonRdsSqlServer_Agent_Job_History_StepName]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_Agent_Job_History_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]