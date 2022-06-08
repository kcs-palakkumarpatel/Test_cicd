CREATE FUNCTION [data].[AzureManagedInstance_QueryPlans_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_QueryPlans_Sightings]
    WHERE [data].[AzureManagedInstance_QueryPlans_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_QueryPlans_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_QueryPlans_CreateDate], [AzureManagedInstance_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[AzureManagedInstance_QueryPlans_Keys].[Id]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[ParentId]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[_CreateDate] AS [AzureManagedInstance_QueryPlans_CreateDate]
    , [data].[AzureManagedInstance_QueryPlans_Keys].[_PlanHandle] AS [AzureManagedInstance_QueryPlans_PlanHandle]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_QueryPlans_Keys] ON [data].[AzureManagedInstance_QueryPlans_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_QueryPlans_Keys].[ParentId]
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
FROM
 [SightedInstances]