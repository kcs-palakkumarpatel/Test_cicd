CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TopQueries_DatabaseName AS NVARCHAR(450)
    , @AzureManagedInstance_TopQueries_SqlHandle AS VARBINARY(900)
    , @AzureManagedInstance_TopQueries_StatementEnd AS BIGINT
    , @AzureManagedInstance_TopQueries_StatementStart AS BIGINT
    , @AzureManagedInstance_TopQueries_QueryWaitStats_WaitType AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TopQueries_DatabaseName], [AzureManagedInstance_TopQueries_SqlHandle], [AzureManagedInstance_TopQueries_StatementEnd], [AzureManagedInstance_TopQueries_StatementStart], [AzureManagedInstance_TopQueries_QueryWaitStats_WaitType]) AS
(
    SELECT [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id]
    , [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[ParentId]
    , [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] AS [AzureManagedInstance_TopQueries_DatabaseName]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] AS [AzureManagedInstance_TopQueries_SqlHandle]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] AS [AzureManagedInstance_TopQueries_StatementEnd]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] AS [AzureManagedInstance_TopQueries_StatementStart]
    , [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [AzureManagedInstance_TopQueries_QueryWaitStats_WaitType]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] ON [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[ParentId] = [data].[AzureManagedInstance_TopQueries_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] = @AzureManagedInstance_TopQueries_DatabaseName
     AND [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] = @AzureManagedInstance_TopQueries_SqlHandle
     AND [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] = @AzureManagedInstance_TopQueries_StatementEnd
     AND [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] = @AzureManagedInstance_TopQueries_StatementStart
     AND [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[_WaitType] = @AzureManagedInstance_TopQueries_QueryWaitStats_WaitType
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TopQueries_DatabaseName]
, [SightedInstances].[AzureManagedInstance_TopQueries_SqlHandle]
, [SightedInstances].[AzureManagedInstance_TopQueries_StatementEnd]
, [SightedInstances].[AzureManagedInstance_TopQueries_StatementStart]
, [SightedInstances].[AzureManagedInstance_TopQueries_QueryWaitStats_WaitType]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_LoginName] AS [AzureManagedInstance_TopQueries_QueryWaitStats_LoginName]
, [Leaf].[_ProgramName] AS [AzureManagedInstance_TopQueries_QueryWaitStats_ProgramName]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate