CREATE FUNCTION [data].[AzureManagedInstance_TraceFlags_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_TraceFlags_Sightings]
    WHERE [data].[AzureManagedInstance_TraceFlags_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TraceFlags_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TraceFlags_TraceFlag]) AS
(
    SELECT [data].[AzureManagedInstance_TraceFlags_Keys].[Id]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[ParentId]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[_TraceFlag] AS [AzureManagedInstance_TraceFlags_TraceFlag]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_TraceFlags_Keys] ON [data].[AzureManagedInstance_TraceFlags_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TraceFlags_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TraceFlags_TraceFlag]
FROM
 [SightedInstances]