CREATE FUNCTION [data].[AzureSqlServer_Database_QueryPlans_Keys_DateRange]
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
    FROM [data].[AzureSqlServer_Database_QueryPlans_Sightings]
    WHERE [data].[AzureSqlServer_Database_QueryPlans_Sightings].[SightingDate] >= @MinDate AND [data].[AzureSqlServer_Database_QueryPlans_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureSqlServer_Name], [AzureSqlServer_Database_Name], [AzureSqlServer_Database_QueryPlans_CreateDate], [AzureSqlServer_Database_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[AzureSqlServer_Database_QueryPlans_Keys].[Id]
    , [data].[AzureSqlServer_Database_QueryPlans_Keys].[ParentId]
    , [data].[AzureSqlServer_Database_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureSqlServer_Keys].[_Name] AS [AzureSqlServer_Name]
    , [data].[AzureSqlServer_Database_Keys].[_Name] AS [AzureSqlServer_Database_Name]
    , [data].[AzureSqlServer_Database_QueryPlans_Keys].[_CreateDate] AS [AzureSqlServer_Database_QueryPlans_CreateDate]
    , [data].[AzureSqlServer_Database_QueryPlans_Keys].[_PlanHandle] AS [AzureSqlServer_Database_QueryPlans_PlanHandle]
    FROM [SightedIds]
     INNER JOIN [data].[AzureSqlServer_Database_QueryPlans_Keys] ON [data].[AzureSqlServer_Database_QueryPlans_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[Id] = [data].[AzureSqlServer_Database_QueryPlans_Keys].[ParentId]
     INNER JOIN [data].[AzureSqlServer_Keys] ON [data].[AzureSqlServer_Keys].[Id] = [data].[AzureSqlServer_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureSqlServer_Name]
, [SightedInstances].[AzureSqlServer_Database_Name]
, [SightedInstances].[AzureSqlServer_Database_QueryPlans_CreateDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureSqlServer_Database_QueryPlans_CreateDate]) AS [AzureSqlServer_Database_QueryPlans_CreateDate_DateTime]
, [SightedInstances].[AzureSqlServer_Database_QueryPlans_PlanHandle]
FROM
 [SightedInstances]