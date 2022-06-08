CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_History_Instances_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name], [AmazonRdsSqlServer_Agent_Job_History_Id], [AmazonRdsSqlServer_Agent_Job_History_RunDate]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    , [TopEvents].[_Id] AS [AmazonRdsSqlServer_Agent_Job_History_Id]
    , [TopEvents].[_RunDate] AS [AmazonRdsSqlServer_Agent_Job_History_RunDate]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[Id]
            , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[CollectionDate]
            , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_Id]
            , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate]
            FROM [data].[AmazonRdsSqlServer_Agent_Job_History_Keys]
             WHERE [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
             AND [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] >= @MinDate
             AND [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] <= @MaxDate
            ORDER BY [_RunDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AmazonRdsSqlServer_Name]
, [TopInstances].[AmazonRdsSqlServer_Agent_Job_Name]
, [TopInstances].[AmazonRdsSqlServer_Agent_Job_History_Id]
, [TopInstances].[AmazonRdsSqlServer_Agent_Job_History_RunDate]
, [utils].[TicksToDateTime]([TopInstances].[AmazonRdsSqlServer_Agent_Job_History_RunDate]) AS [AmazonRdsSqlServer_Agent_Job_History_RunDate_DateTime]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[CollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[CollectionDate]) AS [CollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_Message] AS [AmazonRdsSqlServer_Agent_Job_History_Message]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_RunDuration] AS [AmazonRdsSqlServer_Agent_Job_History_RunDuration]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_RunStatus] AS [AmazonRdsSqlServer_Agent_Job_History_RunStatus]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_SqlMessageId] AS [AmazonRdsSqlServer_Agent_Job_History_SqlMessageId]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_SqlSeverity] AS [AmazonRdsSqlServer_Agent_Job_History_SqlSeverity]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_StepID] AS [AmazonRdsSqlServer_Agent_Job_History_StepID]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_StepMessage] AS [AmazonRdsSqlServer_Agent_Job_History_StepMessage]
, [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[_StepName] AS [AmazonRdsSqlServer_Agent_Job_History_StepName]
FROM [TopInstances]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_History_Instances]
 ON [TopInstances].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_History_Instances].[Id]