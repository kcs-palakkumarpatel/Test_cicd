CREATE FUNCTION [data].[AzureManagedInstance_Resources_StableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Keys].[Id]
    , [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    FROM [data].[AzureManagedInstance_Keys]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_HardwareGeneration] AS [AzureManagedInstance_Resources_HardwareGeneration]
, [Leaf].[_ReservedStorageBytes] AS [AzureManagedInstance_Resources_ReservedStorageBytes]
, [Leaf].[_ResourceName] AS [AzureManagedInstance_Resources_ResourceName]
, [Leaf].[_ResourceType] AS [AzureManagedInstance_Resources_ResourceType]
, [Leaf].[_Sku] AS [AzureManagedInstance_Resources_Sku]
, [Leaf].[_StorageSpaceUsedBytes] AS [AzureManagedInstance_Resources_StorageSpaceUsedBytes]
, [Leaf].[_VirtualCoreCount] AS [AzureManagedInstance_Resources_VirtualCoreCount]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Resources_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Resources_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate