CREATE FUNCTION [data].[AzureManagedInstance_Services_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_Services_Sightings]
    WHERE [data].[AzureManagedInstance_Services_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Services_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Services_ServiceName]) AS
(
    SELECT [data].[AzureManagedInstance_Services_Keys].[Id]
    , [data].[AzureManagedInstance_Services_Keys].[ParentId]
    , [data].[AzureManagedInstance_Services_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Services_Keys].[_ServiceName] AS [AzureManagedInstance_Services_ServiceName]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Services_Keys] ON [data].[AzureManagedInstance_Services_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Services_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Services_ServiceName]
FROM
 [SightedInstances]