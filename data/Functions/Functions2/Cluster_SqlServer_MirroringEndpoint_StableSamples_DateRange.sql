CREATE FUNCTION [data].[Cluster_SqlServer_MirroringEndpoint_StableSamples_DateRange]
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
    FROM [data].[Cluster_SqlServer_MirroringEndpoint_Sightings]
    WHERE [data].[Cluster_SqlServer_MirroringEndpoint_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_MirroringEndpoint_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_MirroringEndpoint_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[Id]
    , [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[ParentId]
    , [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[_Name] AS [Cluster_SqlServer_MirroringEndpoint_Name]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_MirroringEndpoint_Keys] ON [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_MirroringEndpoint_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_MirroringEndpoint_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_EncryptionAlgorithm] AS [Cluster_SqlServer_MirroringEndpoint_EncryptionAlgorithm]
, [Leaf].[_EncryptionEnabled] AS [Cluster_SqlServer_MirroringEndpoint_EncryptionEnabled]
, [Leaf].[_Role] AS [Cluster_SqlServer_MirroringEndpoint_Role]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_MirroringEndpoint_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_MirroringEndpoint_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate