CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_UnstableSamples_CumulativeDifferential]
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
    FROM [data].[AzureManagedInstance_ServerWaits_Sightings]
    WHERE [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] <= @MaxDate
)
SELECT
[data].[AzureManagedInstance_ServerWaits_Keys].[Id]
, [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
, [data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate]) AS [IdCollectionDate_DateTime]
, [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
, [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] AS [AzureManagedInstance_ServerWaits_WaitType]
, [RightLeaf].[CollectionDate]
, ([RightLeaf].[AzureManagedInstance_ServerWaits_SignalWaitTime] - ISNULL([LeftLeaf].[AzureManagedInstance_ServerWaits_SignalWaitTime],0)) AS [AzureManagedInstance_ServerWaits_SignalWaitTime]
, ([RightLeaf].[AzureManagedInstance_ServerWaits_WaitingTasksCount] - ISNULL([LeftLeaf].[AzureManagedInstance_ServerWaits_WaitingTasksCount],0)) AS [AzureManagedInstance_ServerWaits_WaitingTasksCount]
, ([RightLeaf].[AzureManagedInstance_ServerWaits_WaitTime] - ISNULL([LeftLeaf].[AzureManagedInstance_ServerWaits_WaitTime],0)) AS [AzureManagedInstance_ServerWaits_WaitTime]
FROM [SightedIds]
 INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[Id] = [SightedIds].[Id]
 INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
OUTER APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_SignalWaitTime] AS [AzureManagedInstance_ServerWaits_SignalWaitTime]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitingTasksCount] AS [AzureManagedInstance_ServerWaits_WaitingTasksCount]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitTime] AS [AzureManagedInstance_ServerWaits_WaitTime]
    FROM [data].[AzureManagedInstance_ServerWaits_UnstableSamples]
    WHERE [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
      AND [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] <= @MinDate
    ORDER BY [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] DESC
)
 AS [LeftLeaf]CROSS APPLY
(
    SELECT TOP 1 [CollectionDate]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_SignalWaitTime] AS [AzureManagedInstance_ServerWaits_SignalWaitTime]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitingTasksCount] AS [AzureManagedInstance_ServerWaits_WaitingTasksCount]
    ,  [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[_WaitTime] AS [AzureManagedInstance_ServerWaits_WaitTime]
    FROM [data].[AzureManagedInstance_ServerWaits_UnstableSamples]
    WHERE [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
      AND [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] > @MinDate
      AND [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] <= @MaxDate
    ORDER BY [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate] DESC
)
 AS [RightLeaf]