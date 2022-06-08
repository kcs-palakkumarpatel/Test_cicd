CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ServerWaits_WaitType AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ServerWaits_WaitType]) AS
(
    SELECT [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] AS [AzureManagedInstance_ServerWaits_WaitType]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] = @AzureManagedInstance_ServerWaits_WaitType
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_ServerWaits_WaitType]
FROM
 [SightedInstances]