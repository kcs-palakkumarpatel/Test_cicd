CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_Projection_UnstableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_ClusterSharedVolumes_VolumeGuid AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_ClusterSharedVolumes_VolumeGuid]) AS
(
    SELECT [data].[Cluster_ClusterSharedVolumes_Keys].[Id]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] AS [Cluster_ClusterSharedVolumes_VolumeGuid]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_ClusterSharedVolumes_Keys] ON [data].[Cluster_ClusterSharedVolumes_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_ClusterSharedVolumes_Keys].[_VolumeGuid] = @Cluster_ClusterSharedVolumes_VolumeGuid
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_ClusterSharedVolumes_VolumeGuid]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_EstimatedFullDate] AS [Cluster_ClusterSharedVolumes_Projection_EstimatedFullDate]
, [utils].[TicksToDateTime]([Leaf].[_EstimatedFullDate]) AS [Cluster_ClusterSharedVolumes_Projection_EstimatedFullDate_DateTime]
, [Leaf].[_SizeInOneYear] AS [Cluster_ClusterSharedVolumes_Projection_SizeInOneYear]
, [Leaf].[_SizeNow] AS [Cluster_ClusterSharedVolumes_Projection_SizeNow]
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
    , [_EstimatedFullDate]
    , [_SizeInOneYear]
    , [_SizeNow]
    FROM [data].[Cluster_ClusterSharedVolumes_Projection_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]