CREATE FUNCTION [data].[Cluster_SqlServer_QueryPlans_Instances_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_QueryPlans_CreateDate AS BIGINT
    , @Cluster_SqlServer_QueryPlans_PlanHandle AS VARBINARY(900)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_QueryPlans_CreateDate], [Cluster_SqlServer_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[Cluster_SqlServer_QueryPlans_Keys].[Id]
    , [data].[Cluster_SqlServer_QueryPlans_Keys].[ParentId]
    , [data].[Cluster_SqlServer_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_QueryPlans_Keys].[_CreateDate] AS [Cluster_SqlServer_QueryPlans_CreateDate]
    , [data].[Cluster_SqlServer_QueryPlans_Keys].[_PlanHandle] AS [Cluster_SqlServer_QueryPlans_PlanHandle]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_QueryPlans_Keys] ON [data].[Cluster_SqlServer_QueryPlans_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_QueryPlans_Keys].[_CreateDate] = @Cluster_SqlServer_QueryPlans_CreateDate
     AND [data].[Cluster_SqlServer_QueryPlans_Keys].[_PlanHandle] = @Cluster_SqlServer_QueryPlans_PlanHandle
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_QueryPlans_CreateDate]
, [utils].[TicksToDateTime]([SightedInstances].[Cluster_SqlServer_QueryPlans_CreateDate]) AS [Cluster_SqlServer_QueryPlans_CreateDate_DateTime]
, [SightedInstances].[Cluster_SqlServer_QueryPlans_PlanHandle]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_DatabaseName] AS [Cluster_SqlServer_QueryPlans_DatabaseName]
, [Leaf].[_PlanHash] AS [Cluster_SqlServer_QueryPlans_PlanHash]
, [Leaf].[_QueryPlan] AS [Cluster_SqlServer_QueryPlans_QueryPlan]
FROM
 [SightedInstances]
INNER JOIN
 [data].[Cluster_SqlServer_QueryPlans_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]