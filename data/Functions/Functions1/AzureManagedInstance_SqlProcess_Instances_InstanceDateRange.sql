CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_Instances_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_SqlProcess_LoginTime AS BIGINT
    , @AzureManagedInstance_SqlProcess_SessionId AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_SqlProcess_LoginTime], [AzureManagedInstance_SqlProcess_SessionId]) AS
(
    SELECT [data].[AzureManagedInstance_SqlProcess_Keys].[Id]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[ParentId]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[_LoginTime] AS [AzureManagedInstance_SqlProcess_LoginTime]
    , [data].[AzureManagedInstance_SqlProcess_Keys].[_SessionId] AS [AzureManagedInstance_SqlProcess_SessionId]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_SqlProcess_Keys] ON [data].[AzureManagedInstance_SqlProcess_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_SqlProcess_Keys].[_LoginTime] = @AzureManagedInstance_SqlProcess_LoginTime
     AND [data].[AzureManagedInstance_SqlProcess_Keys].[_SessionId] = @AzureManagedInstance_SqlProcess_SessionId
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