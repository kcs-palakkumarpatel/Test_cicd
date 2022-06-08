CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Objects_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_TempDB_Objects_Sightings]
    WHERE [data].[AzureManagedInstance_TempDB_Objects_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TempDB_Objects_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TempDB_Objects_TempTableName]) AS
(
    SELECT [data].[AzureManagedInstance_TempDB_Objects_Keys].[Id]
    , [data].[AzureManagedInstance_TempDB_Objects_Keys].[ParentId]
    , [data].[AzureManagedInstance_TempDB_Objects_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TempDB_Objects_Keys].[_TempTableName] AS [AzureManagedInstance_TempDB_Objects_TempTableName]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_TempDB_Objects_Keys] ON [data].[AzureManagedInstance_TempDB_Objects_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TempDB_Objects_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TempDB_Objects_TempTableName]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ReservedBytes] AS [AzureManagedInstance_TempDB_Objects_ReservedBytes]
, [Leaf].[_RowCount] AS [AzureManagedInstance_TempDB_Objects_RowCount]
, [Leaf].[_UsedBytes] AS [AzureManagedInstance_TempDB_Objects_UsedBytes]
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
    , [_ReservedBytes]
    , [_RowCount]
    , [_UsedBytes]
    FROM [data].[AzureManagedInstance_TempDB_Objects_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]