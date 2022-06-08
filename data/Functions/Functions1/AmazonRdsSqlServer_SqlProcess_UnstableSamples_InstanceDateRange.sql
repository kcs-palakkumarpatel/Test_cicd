CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_SqlProcess_LoginTime AS BIGINT
    , @AmazonRdsSqlServer_SqlProcess_SessionId AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_SqlProcess_LoginTime], [AmazonRdsSqlServer_SqlProcess_SessionId]) AS
(
    SELECT [data].[AmazonRdsSqlServer_SqlProcess_Keys].[Id]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] AS [AmazonRdsSqlServer_SqlProcess_LoginTime]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] AS [AmazonRdsSqlServer_SqlProcess_SessionId]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_Keys] ON [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] = @AmazonRdsSqlServer_SqlProcess_LoginTime
     AND [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] = @AmazonRdsSqlServer_SqlProcess_SessionId
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]) AS [AmazonRdsSqlServer_SqlProcess_LoginTime_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_SessionId]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_BlockingSessionId] AS [AmazonRdsSqlServer_SqlProcess_BlockingSessionId]
, [Leaf].[_BlockingSessionLoginTime] AS [AmazonRdsSqlServer_SqlProcess_BlockingSessionLoginTime]
, [utils].[TicksToDateTime]([Leaf].[_BlockingSessionLoginTime]) AS [AmazonRdsSqlServer_SqlProcess_BlockingSessionLoginTime_DateTime]
, [Leaf].[_Command] AS [AmazonRdsSqlServer_SqlProcess_Command]
, [Leaf].[_CumulativeLogicalReads] AS [AmazonRdsSqlServer_SqlProcess_CumulativeLogicalReads]
, [Leaf].[_CumulativeProcessorTime] AS [AmazonRdsSqlServer_SqlProcess_CumulativeProcessorTime]
, [Leaf].[_CumulativeReads] AS [AmazonRdsSqlServer_SqlProcess_CumulativeReads]
, [Leaf].[_CumulativeWrites] AS [AmazonRdsSqlServer_SqlProcess_CumulativeWrites]
, [Leaf].[_DatabaseName] AS [AmazonRdsSqlServer_SqlProcess_DatabaseName]
, [Leaf].[_ExecutingProcedure] AS [AmazonRdsSqlServer_SqlProcess_ExecutingProcedure]
, [Leaf].[_FullCommand] AS [AmazonRdsSqlServer_SqlProcess_FullCommand]
, [Leaf].[_InternalObjectsAllocBytes] AS [AmazonRdsSqlServer_SqlProcess_InternalObjectsAllocBytes]
, [Leaf].[_InternalObjectsDeallocBytes] AS [AmazonRdsSqlServer_SqlProcess_InternalObjectsDeallocBytes]
, [Leaf].[_LastRequestEnd] AS [AmazonRdsSqlServer_SqlProcess_LastRequestEnd]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestEnd]) AS [AmazonRdsSqlServer_SqlProcess_LastRequestEnd_DateTime]
, [Leaf].[_LastRequestStart] AS [AmazonRdsSqlServer_SqlProcess_LastRequestStart]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestStart]) AS [AmazonRdsSqlServer_SqlProcess_LastRequestStart_DateTime]
, [Leaf].[_LastWaitType] AS [AmazonRdsSqlServer_SqlProcess_LastWaitType]
, [Leaf].[_MemoryUsage] AS [AmazonRdsSqlServer_SqlProcess_MemoryUsage]
, [Leaf].[_MostRecentSqlHandle] AS [AmazonRdsSqlServer_SqlProcess_MostRecentSqlHandle]
, [Leaf].[_OpenTransactions] AS [AmazonRdsSqlServer_SqlProcess_OpenTransactions]
, [Leaf].[_PlanHandle] AS [AmazonRdsSqlServer_SqlProcess_PlanHandle]
, [Leaf].[_QueryHash] AS [AmazonRdsSqlServer_SqlProcess_QueryHash]
, [Leaf].[_QueryPlanHash] AS [AmazonRdsSqlServer_SqlProcess_QueryPlanHash]
, [Leaf].[_QueryStartTime] AS [AmazonRdsSqlServer_SqlProcess_QueryStartTime]
, [utils].[TicksToDateTime]([Leaf].[_QueryStartTime]) AS [AmazonRdsSqlServer_SqlProcess_QueryStartTime_DateTime]
, [Leaf].[_QueryStartTimeIsCalculated] AS [AmazonRdsSqlServer_SqlProcess_QueryStartTimeIsCalculated]
, [Leaf].[_SqlHandle] AS [AmazonRdsSqlServer_SqlProcess_SqlHandle]
, [Leaf].[_StatementEnd] AS [AmazonRdsSqlServer_SqlProcess_StatementEnd]
, [Leaf].[_StatementStart] AS [AmazonRdsSqlServer_SqlProcess_StatementStart]
, [Leaf].[_Status] AS [AmazonRdsSqlServer_SqlProcess_Status]
, [Leaf].[_TotalBlockingTime] AS [AmazonRdsSqlServer_SqlProcess_TotalBlockingTime]
, [Leaf].[_UserObjectsAllocBytes] AS [AmazonRdsSqlServer_SqlProcess_UserObjectsAllocBytes]
, [Leaf].[_UserObjectsDeallocBytes] AS [AmazonRdsSqlServer_SqlProcess_UserObjectsDeallocBytes]
, [Leaf].[_UserObjectsDeferredDeallocBytes] AS [AmazonRdsSqlServer_SqlProcess_UserObjectsDeferredDeallocBytes]
, [Leaf].[_WaitResource] AS [AmazonRdsSqlServer_SqlProcess_WaitResource]
, [Leaf].[_WaitTime] AS [AmazonRdsSqlServer_SqlProcess_WaitTime]
, [Leaf].[_WaitType] AS [AmazonRdsSqlServer_SqlProcess_WaitType]
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
    FROM [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]