CREATE FUNCTION [data].[AzureManagedInstance_Error_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Error_LogDate AS BIGINT
    , @AzureManagedInstance_Error_SequenceNumber AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Error_LogDate], [AzureManagedInstance_Error_SequenceNumber]) AS
(
    SELECT [data].[AzureManagedInstance_Error_Keys].[Id]
    , [data].[AzureManagedInstance_Error_Keys].[ParentId]
    , [data].[AzureManagedInstance_Error_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Error_Keys].[_LogDate] AS [AzureManagedInstance_Error_LogDate]
    , [data].[AzureManagedInstance_Error_Keys].[_SequenceNumber] AS [AzureManagedInstance_Error_SequenceNumber]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Error_Keys] ON [data].[AzureManagedInstance_Error_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Error_Keys].[_LogDate] = @AzureManagedInstance_Error_LogDate
     AND [data].[AzureManagedInstance_Error_Keys].[_SequenceNumber] = @AzureManagedInstance_Error_SequenceNumber
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Error_LogDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_Error_LogDate]) AS [AzureManagedInstance_Error_LogDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Error_SequenceNumber]
FROM
 [SightedInstances]