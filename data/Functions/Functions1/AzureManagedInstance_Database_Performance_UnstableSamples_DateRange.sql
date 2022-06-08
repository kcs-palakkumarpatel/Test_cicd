CREATE FUNCTION [data].[AzureManagedInstance_Database_Performance_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_Sightings]
    WHERE [data].[AzureManagedInstance_Database_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ActiveTransactions] AS [AzureManagedInstance_Database_Performance_ActiveTransactions]
, [Leaf].[_CumulativeLogBytesFlushed] AS [AzureManagedInstance_Database_Performance_CumulativeLogBytesFlushed]
, [Leaf].[_CumulativeLogFlushes] AS [AzureManagedInstance_Database_Performance_CumulativeLogFlushes]
, [Leaf].[_CumulativeLogFlushWaits] AS [AzureManagedInstance_Database_Performance_CumulativeLogFlushWaits]
, [Leaf].[_CumulativeTransactions] AS [AzureManagedInstance_Database_Performance_CumulativeTransactions]
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
    , [_ActiveTransactions]
    , [_CumulativeLogBytesFlushed]
    , [_CumulativeLogFlushes]
    , [_CumulativeLogFlushWaits]
    , [_CumulativeTransactions]
    FROM [data].[AzureManagedInstance_Database_Performance_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]