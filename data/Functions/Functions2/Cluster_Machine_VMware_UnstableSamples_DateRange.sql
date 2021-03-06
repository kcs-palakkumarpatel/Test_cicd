CREATE FUNCTION [data].[Cluster_Machine_VMware_UnstableSamples_DateRange]
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
    FROM [data].[Cluster_Machine_Sightings]
    WHERE [data].[Cluster_Machine_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_Machine_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name]) AS
(
    SELECT [data].[Cluster_Machine_Keys].[Id]
    , [data].[Cluster_Machine_Keys].[ParentId]
    , [data].[Cluster_Machine_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_Machine_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CpuCostop] AS [Cluster_Machine_VMware_CpuCostop]
, [Leaf].[_CpuUsage] AS [Cluster_Machine_VMware_CpuUsage]
, [Leaf].[_DiskLatency] AS [Cluster_Machine_VMware_DiskLatency]
, [Leaf].[_DiskRead] AS [Cluster_Machine_VMware_DiskRead]
, [Leaf].[_DiskWrite] AS [Cluster_Machine_VMware_DiskWrite]
, [Leaf].[_GuestCpuReady] AS [Cluster_Machine_VMware_GuestCpuReady]
, [Leaf].[_GuestCpuSwapWait] AS [Cluster_Machine_VMware_GuestCpuSwapWait]
, [Leaf].[_GuestMemoryBallooned] AS [Cluster_Machine_VMware_GuestMemoryBallooned]
, [Leaf].[_GuestMemoryLatency] AS [Cluster_Machine_VMware_GuestMemoryLatency]
, [Leaf].[_HostMemoryBallooned] AS [Cluster_Machine_VMware_HostMemoryBallooned]
, [Leaf].[_MemorySwapInRate] AS [Cluster_Machine_VMware_MemorySwapInRate]
, [Leaf].[_MemorySwapOutRate] AS [Cluster_Machine_VMware_MemorySwapOutRate]
, [Leaf].[_MemoryUsage] AS [Cluster_Machine_VMware_MemoryUsage]
, [Leaf].[_NetworkUsage] AS [Cluster_Machine_VMware_NetworkUsage]
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
    , [_CpuCostop]
    , [_CpuUsage]
    , [_DiskLatency]
    , [_DiskRead]
    , [_DiskWrite]
    , [_GuestCpuReady]
    , [_GuestCpuSwapWait]
    , [_GuestMemoryBallooned]
    , [_GuestMemoryLatency]
    , [_HostMemoryBallooned]
    , [_MemorySwapInRate]
    , [_MemorySwapOutRate]
    , [_MemoryUsage]
    , [_NetworkUsage]
    FROM [data].[Cluster_Machine_VMware_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]