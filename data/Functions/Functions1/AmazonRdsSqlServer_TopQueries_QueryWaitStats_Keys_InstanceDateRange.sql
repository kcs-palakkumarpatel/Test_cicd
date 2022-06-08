CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys_InstanceDateRange]
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
FROM
 [SightedInstances]