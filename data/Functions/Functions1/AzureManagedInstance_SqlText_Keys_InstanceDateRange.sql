CREATE FUNCTION [data].[AzureManagedInstance_SqlText_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_SqlText_SqlHandle AS VARBINARY(900)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_SqlText_SqlHandle]) AS
(
    SELECT [data].[AzureManagedInstance_SqlText_Keys].[Id]
    , [data].[AzureManagedInstance_SqlText_Keys].[ParentId]
    , [data].[AzureManagedInstance_SqlText_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_SqlText_Keys].[_SqlHandle] AS [AzureManagedInstance_SqlText_SqlHandle]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_SqlText_Keys] ON [data].[AzureManagedInstance_SqlText_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_SqlText_Keys].[_SqlHandle] = @AzureManagedInstance_SqlText_SqlHandle
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_SqlText_SqlHandle]
FROM
 [SightedInstances]