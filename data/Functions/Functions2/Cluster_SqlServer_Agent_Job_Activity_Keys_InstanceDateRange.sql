CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_Activity_Keys_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Agent_Job_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Agent_Job_Activity_RunDate AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Agent_Job_Name], [Cluster_SqlServer_Agent_Job_Activity_RunDate]) AS
(
    SELECT [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[Id]
    , [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] AS [Cluster_SqlServer_Agent_Job_Name]
    , [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[_RunDate] AS [Cluster_SqlServer_Agent_Job_Activity_RunDate]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Activity_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[ParentId] = [data].[Cluster_SqlServer_Agent_Job_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] = @Cluster_SqlServer_Agent_Job_Name
     AND [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[_RunDate] = @Cluster_SqlServer_Agent_Job_Activity_RunDate
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Agent_Job_Name]
, [SightedInstances].[Cluster_SqlServer_Agent_Job_Activity_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[Cluster_SqlServer_Agent_Job_Activity_RunDate]) AS [Cluster_SqlServer_Agent_Job_Activity_RunDate_DateTime]
FROM
 [SightedInstances]