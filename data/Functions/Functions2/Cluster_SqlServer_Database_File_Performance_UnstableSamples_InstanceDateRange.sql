CREATE FUNCTION [data].[Cluster_SqlServer_Database_File_Performance_UnstableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_File_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_File_Type AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Database_Name], [Cluster_SqlServer_Database_File_Name], [Cluster_SqlServer_Database_File_Type]) AS
(
    SELECT [data].[Cluster_SqlServer_Database_File_Keys].[Id]
    , [data].[Cluster_SqlServer_Database_File_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Database_File_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name]
    , [data].[Cluster_SqlServer_Database_File_Keys].[_Name] AS [Cluster_SqlServer_Database_File_Name]
    , [data].[Cluster_SqlServer_Database_File_Keys].[_Type] AS [Cluster_SqlServer_Database_File_Type]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Database_File_Keys] ON [data].[Cluster_SqlServer_Database_File_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_Database_Keys].[_Name] = @Cluster_SqlServer_Database_Name
     AND [data].[Cluster_SqlServer_Database_File_Keys].[_Name] = @Cluster_SqlServer_Database_File_Name
     AND [data].[Cluster_SqlServer_Database_File_Keys].[_Type] = @Cluster_SqlServer_Database_File_Type
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Database_Name]
, [SightedInstances].[Cluster_SqlServer_Database_File_Name]
, [SightedInstances].[Cluster_SqlServer_Database_File_Type]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CumulativeReadBytes] AS [Cluster_SqlServer_Database_File_Performance_CumulativeReadBytes]
, [Leaf].[_CumulativeReadStalls] AS [Cluster_SqlServer_Database_File_Performance_CumulativeReadStalls]
, [Leaf].[_CumulativeReadStallTime] AS [Cluster_SqlServer_Database_File_Performance_CumulativeReadStallTime]
, [Leaf].[_CumulativeWriteBytes] AS [Cluster_SqlServer_Database_File_Performance_CumulativeWriteBytes]
, [Leaf].[_CumulativeWriteStalls] AS [Cluster_SqlServer_Database_File_Performance_CumulativeWriteStalls]
, [Leaf].[_CumulativeWriteStallTime] AS [Cluster_SqlServer_Database_File_Performance_CumulativeWriteStallTime]
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
    , [_CumulativeReadBytes]
    , [_CumulativeReadStalls]
    , [_CumulativeReadStallTime]
    , [_CumulativeWriteBytes]
    , [_CumulativeWriteStalls]
    , [_CumulativeWriteStallTime]
    FROM [data].[Cluster_SqlServer_Database_File_Performance_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]