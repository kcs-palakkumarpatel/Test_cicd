CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_VersionStore_UnstableSamples_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [SightedIds].[Id]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CumulativeCleanupRate] AS [AmazonRdsSqlServer_TempDB_VersionStore_CumulativeCleanupRate]
, [Leaf].[_CumulativeGenerationRate] AS [AmazonRdsSqlServer_TempDB_VersionStore_CumulativeGenerationRate]
, [Leaf].[_LongestRunningTransactionTime] AS [AmazonRdsSqlServer_TempDB_VersionStore_LongestRunningTransactionTime]
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
    , [_CumulativeCleanupRate]
    , [_CumulativeGenerationRate]
    , [_LongestRunningTransactionTime]
    FROM [data].[AmazonRdsSqlServer_TempDB_VersionStore_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]