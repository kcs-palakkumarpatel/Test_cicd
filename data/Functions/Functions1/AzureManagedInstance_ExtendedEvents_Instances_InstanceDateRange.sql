CREATE FUNCTION [data].[AzureManagedInstance_ExtendedEvents_Instances_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ExtendedEvents_EventName AS NVARCHAR(450)
    , @AzureManagedInstance_ExtendedEvents_Sequence AS BIGINT
    , @AzureManagedInstance_ExtendedEvents_TimeStamp AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ExtendedEvents_EventName], [AzureManagedInstance_ExtendedEvents_Sequence], [AzureManagedInstance_ExtendedEvents_TimeStamp]) AS
(
    SELECT [data].[AzureManagedInstance_ExtendedEvents_Keys].[Id]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[ParentId]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_EventName] AS [AzureManagedInstance_ExtendedEvents_EventName]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_Sequence] AS [AzureManagedInstance_ExtendedEvents_Sequence]
    , [data].[AzureManagedInstance_ExtendedEvents_Keys].[_TimeStamp] AS [AzureManagedInstance_ExtendedEvents_TimeStamp]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_ExtendedEvents_Keys] ON [data].[AzureManagedInstance_ExtendedEvents_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_ExtendedEvents_Keys].[_EventName] = @AzureManagedInstance_ExtendedEvents_EventName
     AND [data].[AzureManagedInstance_ExtendedEvents_Keys].[_Sequence] = @AzureManagedInstance_ExtendedEvents_Sequence
     AND [data].[AzureManagedInstance_ExtendedEvents_Keys].[_TimeStamp] = @AzureManagedInstance_ExtendedEvents_TimeStamp
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