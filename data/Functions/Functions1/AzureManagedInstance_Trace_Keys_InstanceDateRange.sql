CREATE FUNCTION [data].[AzureManagedInstance_Trace_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Trace_SequenceNumber AS BIGINT
    , @AzureManagedInstance_Trace_StartTime AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Trace_SequenceNumber], [AzureManagedInstance_Trace_StartTime]) AS
(
    SELECT [data].[AzureManagedInstance_Trace_Keys].[Id]
    , [data].[AzureManagedInstance_Trace_Keys].[ParentId]
    , [data].[AzureManagedInstance_Trace_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Trace_Keys].[_SequenceNumber] AS [AzureManagedInstance_Trace_SequenceNumber]
    , [data].[AzureManagedInstance_Trace_Keys].[_StartTime] AS [AzureManagedInstance_Trace_StartTime]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Trace_Keys] ON [data].[AzureManagedInstance_Trace_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Trace_Keys].[_SequenceNumber] = @AzureManagedInstance_Trace_SequenceNumber
     AND [data].[AzureManagedInstance_Trace_Keys].[_StartTime] = @AzureManagedInstance_Trace_StartTime
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