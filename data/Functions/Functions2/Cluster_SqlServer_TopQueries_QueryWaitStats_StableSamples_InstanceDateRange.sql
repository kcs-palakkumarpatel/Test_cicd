CREATE FUNCTION [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_StableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_TopQueries_DatabaseName AS NVARCHAR(450)
    , @Cluster_SqlServer_TopQueries_SqlHandle AS VARBINARY(900)
    , @Cluster_SqlServer_TopQueries_StatementEnd AS BIGINT
    , @Cluster_SqlServer_TopQueries_StatementStart AS BIGINT
    , @Cluster_SqlServer_TopQueries_QueryWaitStats_WaitType AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_TopQueries_DatabaseName], [Cluster_SqlServer_TopQueries_SqlHandle], [Cluster_SqlServer_TopQueries_StatementEnd], [Cluster_SqlServer_TopQueries_StatementStart], [Cluster_SqlServer_TopQueries_QueryWaitStats_WaitType]) AS
(
    SELECT [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[Id]
    , [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[ParentId]
    , [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_TopQueries_Keys].[_DatabaseName] AS [Cluster_SqlServer_TopQueries_DatabaseName]
    , [data].[Cluster_SqlServer_TopQueries_Keys].[_SqlHandle] AS [Cluster_SqlServer_TopQueries_SqlHandle]
    , [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementEnd] AS [Cluster_SqlServer_TopQueries_StatementEnd]
    , [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementStart] AS [Cluster_SqlServer_TopQueries_StatementStart]
    , [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] AS [Cluster_SqlServer_TopQueries_QueryWaitStats_WaitType]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_TopQueries_Keys] ON [data].[Cluster_SqlServer_TopQueries_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys] ON [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[ParentId] = [data].[Cluster_SqlServer_TopQueries_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_TopQueries_Keys].[_DatabaseName] = @Cluster_SqlServer_TopQueries_DatabaseName
     AND [data].[Cluster_SqlServer_TopQueries_Keys].[_SqlHandle] = @Cluster_SqlServer_TopQueries_SqlHandle
     AND [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementEnd] = @Cluster_SqlServer_TopQueries_StatementEnd
     AND [data].[Cluster_SqlServer_TopQueries_Keys].[_StatementStart] = @Cluster_SqlServer_TopQueries_StatementStart
     AND [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys].[_WaitType] = @Cluster_SqlServer_TopQueries_QueryWaitStats_WaitType
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_TopQueries_DatabaseName]
, [SightedInstances].[Cluster_SqlServer_TopQueries_SqlHandle]
, [SightedInstances].[Cluster_SqlServer_TopQueries_StatementEnd]
, [SightedInstances].[Cluster_SqlServer_TopQueries_StatementStart]
, [SightedInstances].[Cluster_SqlServer_TopQueries_QueryWaitStats_WaitType]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_LoginName] AS [Cluster_SqlServer_TopQueries_QueryWaitStats_LoginName]
, [Leaf].[_ProgramName] AS [Cluster_SqlServer_TopQueries_QueryWaitStats_ProgramName]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate