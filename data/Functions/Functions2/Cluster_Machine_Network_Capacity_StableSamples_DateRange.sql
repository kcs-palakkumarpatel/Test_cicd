CREATE FUNCTION [data].[Cluster_Machine_Network_Capacity_StableSamples_DateRange]
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
    FROM [data].[Cluster_Machine_Network_Sightings]
    WHERE [data].[Cluster_Machine_Network_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_Machine_Network_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_Network_Name], [Cluster_Machine_Network_SequenceNumber]) AS
(
    SELECT [data].[Cluster_Machine_Network_Keys].[Id]
    , [data].[Cluster_Machine_Network_Keys].[ParentId]
    , [data].[Cluster_Machine_Network_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_Network_Keys].[_Name] AS [Cluster_Machine_Network_Name]
    , [data].[Cluster_Machine_Network_Keys].[_SequenceNumber] AS [Cluster_Machine_Network_SequenceNumber]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_Machine_Network_Keys] ON [data].[Cluster_Machine_Network_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[Id] = [data].[Cluster_Machine_Network_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_Machine_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [SightedInstances].[Cluster_Machine_Network_Name]
, [SightedInstances].[Cluster_Machine_Network_SequenceNumber]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_BandwidthBitsPerSecond] AS [Cluster_Machine_Network_Capacity_BandwidthBitsPerSecond]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_Machine_Network_Capacity_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_Machine_Network_Capacity_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate