CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_History_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_History_Id AS BIGINT
    , @AmazonRdsSqlServer_Agent_Job_History_RunDate AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name], [AmazonRdsSqlServer_Agent_Job_History_Id], [AmazonRdsSqlServer_Agent_Job_History_RunDate]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_Id] AS [AmazonRdsSqlServer_Agent_Job_History_Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] AS [AmazonRdsSqlServer_Agent_Job_History_RunDate]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_History_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] = @AmazonRdsSqlServer_Agent_Job_Name
     AND [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_Id] = @AmazonRdsSqlServer_Agent_Job_History_Id
     AND [data].[AmazonRdsSqlServer_Agent_Job_History_Keys].[_RunDate] = @AmazonRdsSqlServer_Agent_Job_History_RunDate
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
FROM
 [SightedInstances]