CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_History_Keys_TopEvents]
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
FROM [TopInstances]