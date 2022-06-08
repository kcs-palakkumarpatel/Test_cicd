CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_UnstableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_SqlProcess_Sightings]
    WHERE [data].[AzureManagedInstance_SqlProcess_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_SqlProcess_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_SqlProcess_LoginTime], [AzureManagedInstance_SqlProcess_SessionId]) AS
(
    SELECT [data].[AzureManagedInstance_SqlProcess_Keys].[Id]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[ParentId]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[_LoginTime] AS [AzureManagedInstance_SqlProcess_LoginTime]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[_SessionId] AS [AzureManagedInstance_SqlProcess_SessionId]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_SqlProcess_Keys] ON [data].[AzureManagedInstance_SqlProcess_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_SqlProcess_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_SqlProcess_LoginTime]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_SqlProcess_LoginTime]) AS [AzureManagedInstance_SqlProcess_LoginTime_DateTime]
, [SightedInstances].[AzureManagedInstance_SqlProcess_SessionId]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_BlockingSessionId] AS [AzureManagedInstance_SqlProcess_BlockingSessionId]
, [Leaf].[_BlockingSessionLoginTime] AS [AzureManagedInstance_SqlProcess_BlockingSessionLoginTime]
, [utils].[TicksToDateTime]([Leaf].[_BlockingSessionLoginTime]) AS [AzureManagedInstance_SqlProcess_BlockingSessionLoginTime_DateTime]
, [Leaf].[_Command] AS [AzureManagedInstance_SqlProcess_Command]
, [Leaf].[_CumulativeLogicalReads] AS [AzureManagedInstance_SqlProcess_CumulativeLogicalReads]
, [Leaf].[_CumulativeProcessorTime] AS [AzureManagedInstance_SqlProcess_CumulativeProcessorTime]
, [Leaf].[_CumulativeReads] AS [AzureManagedInstance_SqlProcess_CumulativeReads]
, [Leaf].[_CumulativeWrites] AS [AzureManagedInstance_SqlProcess_CumulativeWrites]
, [Leaf].[_DatabaseName] AS [AzureManagedInstance_SqlProcess_DatabaseName]
, [Leaf].[_ExecutingProcedure] AS [AzureManagedInstance_SqlProcess_ExecutingProcedure]
, [Leaf].[_FullCommand] AS [AzureManagedInstance_SqlProcess_FullCommand]
, [Leaf].[_InternalObjectsAllocBytes] AS [AzureManagedInstance_SqlProcess_InternalObjectsAllocBytes]
, [Leaf].[_InternalObjectsDeallocBytes] AS [AzureManagedInstance_SqlProcess_InternalObjectsDeallocBytes]
, [Leaf].[_LastRequestEnd] AS [AzureManagedInstance_SqlProcess_LastRequestEnd]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestEnd]) AS [AzureManagedInstance_SqlProcess_LastRequestEnd_DateTime]
, [Leaf].[_LastRequestStart] AS [AzureManagedInstance_SqlProcess_LastRequestStart]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestStart]) AS [AzureManagedInstance_SqlProcess_LastRequestStart_DateTime]
, [Leaf].[_LastWaitType] AS [AzureManagedInstance_SqlProcess_LastWaitType]
, [Leaf].[_MemoryUsage] AS [AzureManagedInstance_SqlProcess_MemoryUsage]
, [Leaf].[_MostRecentSqlHandle] AS [AzureManagedInstance_SqlProcess_MostRecentSqlHandle]
, [Leaf].[_OpenTransactions] AS [AzureManagedInstance_SqlProcess_OpenTransactions]
, [Leaf].[_PlanHandle] AS [AzureManagedInstance_SqlProcess_PlanHandle]
, [Leaf].[_QueryHash] AS [AzureManagedInstance_SqlProcess_QueryHash]
, [Leaf].[_QueryPlanHash] AS [AzureManagedInstance_SqlProcess_QueryPlanHash]
, [Leaf].[_QueryStartTime] AS [AzureManagedInstance_SqlProcess_QueryStartTime]
, [utils].[TicksToDateTime]([Leaf].[_QueryStartTime]) AS [AzureManagedInstance_SqlProcess_QueryStartTime_DateTime]
, [Leaf].[_QueryStartTimeIsCalculated] AS [AzureManagedInstance_SqlProcess_QueryStartTimeIsCalculated]
, [Leaf].[_SqlHandle] AS [AzureManagedInstance_SqlProcess_SqlHandle]
, [Leaf].[_StatementEnd] AS [AzureManagedInstance_SqlProcess_StatementEnd]
, [Leaf].[_StatementStart] AS [AzureManagedInstance_SqlProcess_StatementStart]
, [Leaf].[_Status] AS [AzureManagedInstance_SqlProcess_Status]
, [Leaf].[_TotalBlockingTime] AS [AzureManagedInstance_SqlProcess_TotalBlockingTime]
, [Leaf].[_UserObjectsAllocBytes] AS [AzureManagedInstance_SqlProcess_UserObjectsAllocBytes]
, [Leaf].[_UserObjectsDeallocBytes] AS [AzureManagedInstance_SqlProcess_UserObjectsDeallocBytes]
, [Leaf].[_UserObjectsDeferredDeallocBytes] AS [AzureManagedInstance_SqlProcess_UserObjectsDeferredDeallocBytes]
, [Leaf].[_WaitResource] AS [AzureManagedInstance_SqlProcess_WaitResource]
, [Leaf].[_WaitTime] AS [AzureManagedInstance_SqlProcess_WaitTime]
, [Leaf].[_WaitType] AS [AzureManagedInstance_SqlProcess_WaitType]
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
    , [_BlockingSessionId]
    , [_BlockingSessionLoginTime]
    , [_Command]
    , [_CumulativeLogicalReads]
    , [_CumulativeProcessorTime]
    , [_CumulativeReads]
    , [_CumulativeWrites]
    , [_DatabaseName]
    , [_ExecutingProcedure]
    , [_FullCommand]
    , [_InternalObjectsAllocBytes]
    , [_InternalObjectsDeallocBytes]
    , [_LastRequestEnd]
    , [_LastRequestStart]
    , [_LastWaitType]
    , [_MemoryUsage]
    , [_MostRecentSqlHandle]
    , [_OpenTransactions]
    , [_PlanHandle]
    , [_QueryHash]
    , [_QueryPlanHash]
    , [_QueryStartTime]
    , [_QueryStartTimeIsCalculated]
    , [_SqlHandle]
    , [_StatementEnd]
    , [_StatementStart]
    , [_Status]
    , [_TotalBlockingTime]
    , [_UserObjectsAllocBytes]
    , [_UserObjectsDeallocBytes]
    , [_UserObjectsDeferredDeallocBytes]
    , [_WaitResource]
    , [_WaitTime]
    , [_WaitType]
    FROM [data].[AzureManagedInstance_SqlProcess_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]