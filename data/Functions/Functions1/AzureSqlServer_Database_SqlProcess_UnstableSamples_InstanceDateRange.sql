CREATE FUNCTION [data].[AzureSqlServer_Database_SqlProcess_UnstableSamples_InstanceDateRange]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_SqlProcess_LoginTime AS BIGINT
    , @AzureSqlServer_Database_SqlProcess_SessionId AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureSqlServer_Name], [AzureSqlServer_Database_Name], [AzureSqlServer_Database_SqlProcess_LoginTime], [AzureSqlServer_Database_SqlProcess_SessionId]) AS
(
    SELECT [data].[AzureSqlServer_Database_SqlProcess_Keys].[Id]
    , [data].[AzureSqlServer_Database_SqlProcess_Keys].[ParentId]
    , [data].[AzureSqlServer_Database_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureSqlServer_Keys].[_Name] AS [AzureSqlServer_Name]
    , [data].[AzureSqlServer_Database_Keys].[_Name] AS [AzureSqlServer_Database_Name]
    , [data].[AzureSqlServer_Database_SqlProcess_Keys].[_LoginTime] AS [AzureSqlServer_Database_SqlProcess_LoginTime]
    , [data].[AzureSqlServer_Database_SqlProcess_Keys].[_SessionId] AS [AzureSqlServer_Database_SqlProcess_SessionId]
    FROM [data].[AzureSqlServer_Keys]
    INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[ParentId] = [data].[AzureSqlServer_Keys].[Id]
    INNER JOIN [data].[AzureSqlServer_Database_SqlProcess_Keys] ON [data].[AzureSqlServer_Database_SqlProcess_Keys].[ParentId] = [data].[AzureSqlServer_Database_Keys].[Id]
     WHERE [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name
     AND [data].[AzureSqlServer_Database_Keys].[_Name] = @AzureSqlServer_Database_Name
     AND [data].[AzureSqlServer_Database_SqlProcess_Keys].[_LoginTime] = @AzureSqlServer_Database_SqlProcess_LoginTime
     AND [data].[AzureSqlServer_Database_SqlProcess_Keys].[_SessionId] = @AzureSqlServer_Database_SqlProcess_SessionId
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureSqlServer_Name]
, [SightedInstances].[AzureSqlServer_Database_Name]
, [SightedInstances].[AzureSqlServer_Database_SqlProcess_LoginTime]
, [utils].[TicksToDateTime]([SightedInstances].[AzureSqlServer_Database_SqlProcess_LoginTime]) AS [AzureSqlServer_Database_SqlProcess_LoginTime_DateTime]
, [SightedInstances].[AzureSqlServer_Database_SqlProcess_SessionId]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_BlockingSessionId] AS [AzureSqlServer_Database_SqlProcess_BlockingSessionId]
, [Leaf].[_BlockingSessionLoginTime] AS [AzureSqlServer_Database_SqlProcess_BlockingSessionLoginTime]
, [utils].[TicksToDateTime]([Leaf].[_BlockingSessionLoginTime]) AS [AzureSqlServer_Database_SqlProcess_BlockingSessionLoginTime_DateTime]
, [Leaf].[_Command] AS [AzureSqlServer_Database_SqlProcess_Command]
, [Leaf].[_CumulativeLogicalReads] AS [AzureSqlServer_Database_SqlProcess_CumulativeLogicalReads]
, [Leaf].[_CumulativeProcessorTime] AS [AzureSqlServer_Database_SqlProcess_CumulativeProcessorTime]
, [Leaf].[_CumulativeReads] AS [AzureSqlServer_Database_SqlProcess_CumulativeReads]
, [Leaf].[_CumulativeWrites] AS [AzureSqlServer_Database_SqlProcess_CumulativeWrites]
, [Leaf].[_DatabaseName] AS [AzureSqlServer_Database_SqlProcess_DatabaseName]
, [Leaf].[_ExecutingProcedure] AS [AzureSqlServer_Database_SqlProcess_ExecutingProcedure]
, [Leaf].[_FullCommand] AS [AzureSqlServer_Database_SqlProcess_FullCommand]
, [Leaf].[_InternalObjectsAllocBytes] AS [AzureSqlServer_Database_SqlProcess_InternalObjectsAllocBytes]
, [Leaf].[_InternalObjectsDeallocBytes] AS [AzureSqlServer_Database_SqlProcess_InternalObjectsDeallocBytes]
, [Leaf].[_LastRequestEnd] AS [AzureSqlServer_Database_SqlProcess_LastRequestEnd]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestEnd]) AS [AzureSqlServer_Database_SqlProcess_LastRequestEnd_DateTime]
, [Leaf].[_LastRequestStart] AS [AzureSqlServer_Database_SqlProcess_LastRequestStart]
, [utils].[TicksToDateTime]([Leaf].[_LastRequestStart]) AS [AzureSqlServer_Database_SqlProcess_LastRequestStart_DateTime]
, [Leaf].[_LastWaitType] AS [AzureSqlServer_Database_SqlProcess_LastWaitType]
, [Leaf].[_MemoryUsage] AS [AzureSqlServer_Database_SqlProcess_MemoryUsage]
, [Leaf].[_MostRecentSqlHandle] AS [AzureSqlServer_Database_SqlProcess_MostRecentSqlHandle]
, [Leaf].[_OpenTransactions] AS [AzureSqlServer_Database_SqlProcess_OpenTransactions]
, [Leaf].[_PlanHandle] AS [AzureSqlServer_Database_SqlProcess_PlanHandle]
, [Leaf].[_QueryHash] AS [AzureSqlServer_Database_SqlProcess_QueryHash]
, [Leaf].[_QueryPlanHash] AS [AzureSqlServer_Database_SqlProcess_QueryPlanHash]
, [Leaf].[_QueryStartTime] AS [AzureSqlServer_Database_SqlProcess_QueryStartTime]
, [utils].[TicksToDateTime]([Leaf].[_QueryStartTime]) AS [AzureSqlServer_Database_SqlProcess_QueryStartTime_DateTime]
, [Leaf].[_QueryStartTimeIsCalculated] AS [AzureSqlServer_Database_SqlProcess_QueryStartTimeIsCalculated]
, [Leaf].[_SqlHandle] AS [AzureSqlServer_Database_SqlProcess_SqlHandle]
, [Leaf].[_StatementEnd] AS [AzureSqlServer_Database_SqlProcess_StatementEnd]
, [Leaf].[_StatementStart] AS [AzureSqlServer_Database_SqlProcess_StatementStart]
, [Leaf].[_Status] AS [AzureSqlServer_Database_SqlProcess_Status]
, [Leaf].[_TotalBlockingTime] AS [AzureSqlServer_Database_SqlProcess_TotalBlockingTime]
, [Leaf].[_UserObjectsAllocBytes] AS [AzureSqlServer_Database_SqlProcess_UserObjectsAllocBytes]
, [Leaf].[_UserObjectsDeallocBytes] AS [AzureSqlServer_Database_SqlProcess_UserObjectsDeallocBytes]
, [Leaf].[_UserObjectsDeferredDeallocBytes] AS [AzureSqlServer_Database_SqlProcess_UserObjectsDeferredDeallocBytes]
, [Leaf].[_WaitResource] AS [AzureSqlServer_Database_SqlProcess_WaitResource]
, [Leaf].[_WaitTime] AS [AzureSqlServer_Database_SqlProcess_WaitTime]
, [Leaf].[_WaitType] AS [AzureSqlServer_Database_SqlProcess_WaitType]
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
    FROM [data].[AzureSqlServer_Database_SqlProcess_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]