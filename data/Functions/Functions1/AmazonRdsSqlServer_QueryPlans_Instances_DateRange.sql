CREATE FUNCTION [data].[AmazonRdsSqlServer_QueryPlans_Instances_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_QueryPlans_Sightings]
    WHERE [data].[AmazonRdsSqlServer_QueryPlans_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_QueryPlans_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_QueryPlans_CreateDate], [AmazonRdsSqlServer_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[AmazonRdsSqlServer_QueryPlans_Keys].[Id]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_CreateDate] AS [AmazonRdsSqlServer_QueryPlans_CreateDate]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_PlanHandle] AS [AmazonRdsSqlServer_QueryPlans_PlanHandle]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_QueryPlans_Keys] ON [data].[AmazonRdsSqlServer_QueryPlans_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_QueryPlans_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_QueryPlans_CreateDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_QueryPlans_CreateDate]) AS [AmazonRdsSqlServer_QueryPlans_CreateDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_QueryPlans_PlanHandle]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_DatabaseName] AS [AmazonRdsSqlServer_QueryPlans_DatabaseName]
, [Leaf].[_PlanHash] AS [AmazonRdsSqlServer_QueryPlans_PlanHash]
, [Leaf].[_QueryPlan] AS [AmazonRdsSqlServer_QueryPlans_QueryPlan]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_QueryPlans_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]