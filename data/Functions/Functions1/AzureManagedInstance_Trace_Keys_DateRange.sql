CREATE FUNCTION [data].[AzureManagedInstance_Trace_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_Trace_Sightings]
    WHERE [data].[AzureManagedInstance_Trace_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Trace_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Trace_SequenceNumber], [AzureManagedInstance_Trace_StartTime]) AS
(
    SELECT [data].[AzureManagedInstance_Trace_Keys].[Id]
    , [data].[AzureManagedInstance_Trace_Keys].[ParentId]
    , [data].[AzureManagedInstance_Trace_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Trace_Keys].[_SequenceNumber] AS [AzureManagedInstance_Trace_SequenceNumber]
    , [data].[AzureManagedInstance_Trace_Keys].[_StartTime] AS [AzureManagedInstance_Trace_StartTime]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Trace_Keys] ON [data].[AzureManagedInstance_Trace_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Trace_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Trace_SequenceNumber]
, [SightedInstances].[AzureManagedInstance_Trace_StartTime]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_Trace_StartTime]) AS [AzureManagedInstance_Trace_StartTime_DateTime]
FROM
 [SightedInstances]