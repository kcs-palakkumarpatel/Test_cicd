CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_StableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_AutoCreateStatistics] AS [AmazonRdsSqlServer_Database_AutoCreateStatistics]
, [Leaf].[_AutoShrink] AS [AmazonRdsSqlServer_Database_AutoShrink]
, [Leaf].[_Collation] AS [AmazonRdsSqlServer_Database_Collation]
, [Leaf].[_CompatibilityLevel] AS [AmazonRdsSqlServer_Database_CompatibilityLevel]
, [Leaf].[_CreateDate] AS [AmazonRdsSqlServer_Database_CreateDate]
, [utils].[TicksToDateTime]([Leaf].[_CreateDate]) AS [AmazonRdsSqlServer_Database_CreateDate_DateTime]
, [Leaf].[_DatabaseId] AS [AmazonRdsSqlServer_Database_DatabaseId]
, [Leaf].[_Owner] AS [AmazonRdsSqlServer_Database_Owner]
, [Leaf].[_PageVerify] AS [AmazonRdsSqlServer_Database_PageVerify]
, [Leaf].[_ReadOnly] AS [AmazonRdsSqlServer_Database_ReadOnly]
, [Leaf].[_RecoveryModel] AS [AmazonRdsSqlServer_Database_RecoveryModel]
, [Leaf].[_Standby] AS [AmazonRdsSqlServer_Database_Standby]
, [Leaf].[_State] AS [AmazonRdsSqlServer_Database_State]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AmazonRdsSqlServer_Database_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AmazonRdsSqlServer_Database_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate