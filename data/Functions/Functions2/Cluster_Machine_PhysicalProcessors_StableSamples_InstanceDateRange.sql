CREATE FUNCTION [data].[Cluster_Machine_PhysicalProcessors_StableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_Machine_Name AS NVARCHAR(450)
    , @Cluster_Machine_PhysicalProcessors_DeviceID AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_PhysicalProcessors_DeviceID]) AS
(
    SELECT [data].[Cluster_Machine_PhysicalProcessors_Keys].[Id]
    , [data].[Cluster_Machine_PhysicalProcessors_Keys].[ParentId]
    , [data].[Cluster_Machine_PhysicalProcessors_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_PhysicalProcessors_Keys].[_DeviceID] AS [Cluster_Machine_PhysicalProcessors_DeviceID]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_Machine_PhysicalProcessors_Keys] ON [data].[Cluster_Machine_PhysicalProcessors_Keys].[ParentId] = [data].[Cluster_Machine_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_Machine_Keys].[_Name] = @Cluster_Machine_Name
     AND [data].[Cluster_Machine_PhysicalProcessors_Keys].[_DeviceID] = @Cluster_Machine_PhysicalProcessors_DeviceID
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [SightedInstances].[Cluster_Machine_PhysicalProcessors_DeviceID]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_NumberOfCores] AS [Cluster_Machine_PhysicalProcessors_NumberOfCores]
, [Leaf].[_NumberOfEnabledCore] AS [Cluster_Machine_PhysicalProcessors_NumberOfEnabledCore]
, [Leaf].[_NumberOfLogicalProcessors] AS [Cluster_Machine_PhysicalProcessors_NumberOfLogicalProcessors]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_Machine_PhysicalProcessors_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_Machine_PhysicalProcessors_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate