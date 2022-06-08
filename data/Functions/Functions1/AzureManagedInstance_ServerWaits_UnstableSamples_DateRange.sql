CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_ServerWaits_Sightings]
    WHERE [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ServerWaits_WaitType]) AS
(
    SELECT [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] AS [AzureManagedInstance_ServerWaits_WaitType]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_ServerWaits_WaitType]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_SignalWaitTime] AS [AzureManagedInstance_ServerWaits_SignalWaitTime]
, [Leaf].[_WaitingTasksCount] AS [AzureManagedInstance_ServerWaits_WaitingTasksCount]
, [Leaf].[_WaitTime] AS [AzureManagedInstance_ServerWaits_WaitTime]
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
    , [_SignalWaitTime]
    , [_WaitingTasksCount]
    , [_WaitTime]
    FROM [data].[AzureManagedInstance_ServerWaits_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]