CREATE FUNCTION [data].[AzureManagedInstance_ExtendedEvents_Instances_DateRange]
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
    FROM [data].[AzureManagedInstance_ExtendedEvents_Sightings]
    WHERE [data].[AzureManagedInstance_ExtendedEvents_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_ExtendedEvents_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ExtendedEvents_EventName], [AzureManagedInstance_ExtendedEvents_Sequence], [AzureManagedInstance_ExtendedEvents_TimeStamp]) AS
(
    SELECT [data].[AzureManagedInstance_ExtendedEvents_Keys].[Id]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[ParentId]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_EventName] AS [AzureManagedInstance_ExtendedEvents_EventName]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_Sequence] AS [AzureManagedInstance_ExtendedEvents_Sequence]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_TimeStamp] AS [AzureManagedInstance_ExtendedEvents_TimeStamp]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_ExtendedEvents_Keys] ON [data].[AzureManagedInstance_ExtendedEvents_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ExtendedEvents_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_ExtendedEvents_EventName]
, [SightedInstances].[AzureManagedInstance_ExtendedEvents_Sequence]
, [SightedInstances].[AzureManagedInstance_ExtendedEvents_TimeStamp]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_ExtendedEvents_TimeStamp]) AS [AzureManagedInstance_ExtendedEvents_TimeStamp_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_EventData] AS [AzureManagedInstance_ExtendedEvents_EventData]
, [Leaf].[_FileName] AS [AzureManagedInstance_ExtendedEvents_FileName]
, [Leaf].[_FileOffset] AS [AzureManagedInstance_ExtendedEvents_FileOffset]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_ExtendedEvents_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]