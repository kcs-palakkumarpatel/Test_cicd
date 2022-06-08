CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_ServerWaits_Sightings]
    WHERE [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ServerWaits_WaitType]) AS
(
    SELECT [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] AS [AzureManagedInstance_ServerWaits_WaitType]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId]
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