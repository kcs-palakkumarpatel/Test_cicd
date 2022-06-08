CREATE FUNCTION [data].[Cluster_SqlServer_Database_Encryption_Key_StableSamples_DateRange]
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
    FROM [data].[Cluster_SqlServer_Database_Encryption_Key_Sightings]
    WHERE [data].[Cluster_SqlServer_Database_Encryption_Key_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_Database_Encryption_Key_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Database_Name], [Cluster_SqlServer_Database_Encryption_Key_Id], [Cluster_SqlServer_Database_Encryption_Key_Type]) AS
(
    SELECT [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[Id]
    , [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name]
    , [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[_Id] AS [Cluster_SqlServer_Database_Encryption_Key_Id]
    , [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[_Type] AS [Cluster_SqlServer_Database_Encryption_Key_Type]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_Database_Encryption_Key_Keys] ON [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[Id] = [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[ParentId]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Database_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Database_Name]
, [SightedInstances].[Cluster_SqlServer_Database_Encryption_Key_Id]
, [SightedInstances].[Cluster_SqlServer_Database_Encryption_Key_Type]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Algorithm] AS [Cluster_SqlServer_Database_Encryption_Key_Algorithm]
, [Leaf].[_EncryptionType] AS [Cluster_SqlServer_Database_Encryption_Key_EncryptionType]
, [Leaf].[_Name] AS [Cluster_SqlServer_Database_Encryption_Key_Name]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_Database_Encryption_Key_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_Database_Encryption_Key_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate