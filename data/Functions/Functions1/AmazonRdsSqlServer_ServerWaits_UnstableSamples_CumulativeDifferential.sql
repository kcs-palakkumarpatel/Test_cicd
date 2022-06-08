CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples_CumulativeDifferential]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AmazonRdsSqlServer_ServerWaits_Sightings]
    WHERE [data].[AmazonRdsSqlServer_ServerWaits_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_ServerWaits_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
, [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId]
, [data].[AmazonRdsSqlServer_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_ServerWaits_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
, [data].[AmazonRdsSqlServer_ServerWaits_Keys].[_WaitType] AS [AmazonRdsSqlServer_ServerWaits_WaitType]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AmazonRdsSqlServer_ServerWaits_SignalWaitTime] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_ServerWaits_SignalWaitTime],0)) AS [AmazonRdsSqlServer_ServerWaits_SignalWaitTime]
, ([RightLeaf].[AmazonRdsSqlServer_ServerWaits_WaitingTasksCount] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_ServerWaits_WaitingTasksCount],0)) AS [AmazonRdsSqlServer_ServerWaits_WaitingTasksCount]
, ([RightLeaf].[AmazonRdsSqlServer_ServerWaits_WaitTime] - ISNULL([LeftLeaf].[AmazonRdsSqlServer_ServerWaits_WaitTime],0)) AS [AmazonRdsSqlServer_ServerWaits_WaitTime]
FROM [SightedIds]
 INNER JOIN [data].[AmazonRdsSqlServer_ServerWaits_Keys] ON [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_SignalWaitTime] AS [AmazonRdsSqlServer_ServerWaits_SignalWaitTime]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_WaitingTasksCount] AS [AmazonRdsSqlServer_ServerWaits_WaitingTasksCount]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_WaitTime] AS [AmazonRdsSqlServer_ServerWaits_WaitTime]
    FROM [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_SignalWaitTime] AS [AmazonRdsSqlServer_ServerWaits_SignalWaitTime]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_WaitingTasksCount] AS [AmazonRdsSqlServer_ServerWaits_WaitingTasksCount]
    ,  [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[_WaitTime] AS [AmazonRdsSqlServer_ServerWaits_WaitTime]
    FROM [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples]
    WHERE [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
      AND [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]