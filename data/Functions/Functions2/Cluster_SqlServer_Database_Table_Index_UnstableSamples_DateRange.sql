CREATE FUNCTION [data].[Cluster_SqlServer_Database_Table_Index_UnstableSamples_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[Cluster_SqlServer_Database_Table_Index_Sightings]
    WHERE [data].[Cluster_SqlServer_Database_Table_Index_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_Database_Table_Index_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Database_Name], [Cluster_SqlServer_Database_Table_Name], [Cluster_SqlServer_Database_Table_Schema], [Cluster_SqlServer_Database_Table_Index_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_Database_Table_Index_Keys].[Id]
    , [data].[Cluster_SqlServer_Database_Table_Index_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Database_Table_Index_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name]
    , [data].[Cluster_SqlServer_Database_Table_Keys].[_Name] AS [Cluster_SqlServer_Database_Table_Name]
    , [data].[Cluster_SqlServer_Database_Table_Keys].[_Schema] AS [Cluster_SqlServer_Database_Table_Schema]
    , [data].[Cluster_SqlServer_Database_Table_Index_Keys].[_Name] AS [Cluster_SqlServer_Database_Table_Index_Name]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_Database_Table_Index_Keys] ON [data].[Cluster_SqlServer_Database_Table_Index_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Database_Table_Keys] ON [data].[Cluster_SqlServer_Database_Table_Keys].[Id] = [data].[Cluster_SqlServer_Database_Table_Index_Keys].[ParentId]
     INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[Id] = [data].[Cluster_SqlServer_Database_Table_Keys].[ParentId]
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
, [SightedInstances].[Cluster_SqlServer_Database_Table_Name]
, [SightedInstances].[Cluster_SqlServer_Database_Table_Schema]
, [SightedInstances].[Cluster_SqlServer_Database_Table_Index_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Fragmentation] AS [Cluster_SqlServer_Database_Table_Index_Fragmentation]
, [Leaf].[_Pages] AS [Cluster_SqlServer_Database_Table_Index_Pages]
FROM
 [SightedInstances]
INNER JOIN
(
    -- We partition the date range into n 'bins' and take the last sample in each bin, if available.
    -- We calculate the bin sizes in floating point to handle ranges of less than n ticks, then round up.
    SELECT
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i]    )) AS [PartitionMinDate],
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i] + 1)) AS [PartitionMaxDate]
    FROM [utils].[Nat](@MaxSamples)
    WHERE @MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * [i] < @MaxDate
)
 [PartitionDates] ON 1 = 1
CROSS APPLY
(
    SELECT TOP (@EventCount)
    [CollectionDate]
    , [_Fragmentation]
    , [_Pages]
    FROM [data].[Cluster_SqlServer_Database_Table_Index_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]