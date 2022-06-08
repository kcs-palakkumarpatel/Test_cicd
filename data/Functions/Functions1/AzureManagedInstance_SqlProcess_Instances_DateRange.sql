CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_Instances_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
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
, [Leaf].[_Hostname] AS [AzureManagedInstance_SqlProcess_Hostname]
, [Leaf].[_LoginName] AS [AzureManagedInstance_SqlProcess_LoginName]
, [Leaf].[_ProgramName] AS [AzureManagedInstance_SqlProcess_ProgramName]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_SqlProcess_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]