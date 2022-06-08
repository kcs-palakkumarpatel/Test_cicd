CREATE FUNCTION [data].[AzureManagedInstance_Database_StableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_AutoCreateStatistics] AS [AzureManagedInstance_Database_AutoCreateStatistics]
, [Leaf].[_AutoShrink] AS [AzureManagedInstance_Database_AutoShrink]
, [Leaf].[_Collation] AS [AzureManagedInstance_Database_Collation]
, [Leaf].[_CompatibilityLevel] AS [AzureManagedInstance_Database_CompatibilityLevel]
, [Leaf].[_CreateDate] AS [AzureManagedInstance_Database_CreateDate]
, [utils].[TicksToDateTime]([Leaf].[_CreateDate]) AS [AzureManagedInstance_Database_CreateDate_DateTime]
, [Leaf].[_DatabaseId] AS [AzureManagedInstance_Database_DatabaseId]
, [Leaf].[_Owner] AS [AzureManagedInstance_Database_Owner]
, [Leaf].[_PageVerify] AS [AzureManagedInstance_Database_PageVerify]
, [Leaf].[_ReadOnly] AS [AzureManagedInstance_Database_ReadOnly]
, [Leaf].[_RecoveryModel] AS [AzureManagedInstance_Database_RecoveryModel]
, [Leaf].[_Standby] AS [AzureManagedInstance_Database_Standby]
, [Leaf].[_State] AS [AzureManagedInstance_Database_State]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Database_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Database_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate