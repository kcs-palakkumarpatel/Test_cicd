CREATE FUNCTION [data].[AzureManagedInstance_TraceFlags_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TraceFlags_TraceFlag AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TraceFlags_TraceFlag]) AS
(
    SELECT [data].[AzureManagedInstance_TraceFlags_Keys].[Id]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[ParentId]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TraceFlags_Keys].[_TraceFlag] AS [AzureManagedInstance_TraceFlags_TraceFlag]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_TraceFlags_Keys] ON [data].[AzureManagedInstance_TraceFlags_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_TraceFlags_Keys].[_TraceFlag] = @AzureManagedInstance_TraceFlags_TraceFlag
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