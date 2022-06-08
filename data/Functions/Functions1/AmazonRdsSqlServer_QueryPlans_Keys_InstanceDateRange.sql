CREATE FUNCTION [data].[AmazonRdsSqlServer_QueryPlans_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_QueryPlans_CreateDate AS BIGINT
    , @AmazonRdsSqlServer_QueryPlans_PlanHandle AS VARBINARY(900)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_QueryPlans_CreateDate], [AmazonRdsSqlServer_QueryPlans_PlanHandle]) AS
(
    SELECT [data].[AmazonRdsSqlServer_QueryPlans_Keys].[Id]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_CreateDate] AS [AmazonRdsSqlServer_QueryPlans_CreateDate]
    , [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_PlanHandle] AS [AmazonRdsSqlServer_QueryPlans_PlanHandle]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_QueryPlans_Keys] ON [data].[AmazonRdsSqlServer_QueryPlans_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_CreateDate] = @AmazonRdsSqlServer_QueryPlans_CreateDate
     AND [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_PlanHandle] = @AmazonRdsSqlServer_QueryPlans_PlanHandle
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
FROM
 [SightedInstances]