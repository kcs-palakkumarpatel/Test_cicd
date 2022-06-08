CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_DatabaseName AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_SqlHandle AS VARBINARY(900)
    , @AmazonRdsSqlServer_TopQueries_StatementEnd AS BIGINT
    , @AmazonRdsSqlServer_TopQueries_StatementStart AS BIGINT
    , @AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TopQueries_DatabaseName], [AmazonRdsSqlServer_TopQueries_SqlHandle], [AmazonRdsSqlServer_TopQueries_StatementEnd], [AmazonRdsSqlServer_TopQueries_StatementStart], [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] AS [AmazonRdsSqlServer_TopQueries_DatabaseName]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_TopQueries_SqlHandle]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] AS [AmazonRdsSqlServer_TopQueries_StatementEnd]
    , [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] AS [AmazonRdsSqlServer_TopQueries_StatementStart]
    , [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[ParentId] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] = @AmazonRdsSqlServer_TopQueries_DatabaseName
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] = @AmazonRdsSqlServer_TopQueries_SqlHandle
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] = @AmazonRdsSqlServer_TopQueries_StatementEnd
     AND [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] = @AmazonRdsSqlServer_TopQueries_StatementStart
     AND [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] = @AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_DatabaseName]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_SqlHandle]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_StatementEnd]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_StatementStart]
, [SightedInstances].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitType]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_WaitTime] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTime]
, [Leaf].[_WaitTimeCount] AS [AmazonRdsSqlServer_TopQueries_QueryWaitStats_WaitTimeCount]
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
    , [_WaitTime]
    , [_WaitTimeCount]
    FROM [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]