CREATE FUNCTION [data].[AzureManagedInstance_QueryPlans_Instances_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_QueryPlans_CreateDate AS BIGINT
    , @AzureManagedInstance_QueryPlans_PlanHandle AS VARBINARY(900)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_QueryPlans_CreateDate], [AzureManagedInstance_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[AzureManagedInstance_QueryPlans_Keys].[Id]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[ParentId]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[_CreateDate] AS [AzureManagedInstance_QueryPlans_CreateDate]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[_PlanHandle] AS [AzureManagedInstance_QueryPlans_PlanHandle]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_QueryPlans_Keys] ON [data].[AzureManagedInstance_QueryPlans_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_QueryPlans_Keys].[_CreateDate] = @AzureManagedInstance_QueryPlans_CreateDate
     AND [data].[AzureManagedInstance_QueryPlans_Keys].[_PlanHandle] = @AzureManagedInstance_QueryPlans_PlanHandle
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_QueryPlans_CreateDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_QueryPlans_CreateDate]) AS [AzureManagedInstance_QueryPlans_CreateDate_DateTime]
, [SightedInstances].[AzureManagedInstance_QueryPlans_PlanHandle]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_DatabaseName] AS [AzureManagedInstance_QueryPlans_DatabaseName]
, [Leaf].[_PlanHash] AS [AzureManagedInstance_QueryPlans_PlanHash]
, [Leaf].[_QueryPlan] AS [AzureManagedInstance_QueryPlans_QueryPlan]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_QueryPlans_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]