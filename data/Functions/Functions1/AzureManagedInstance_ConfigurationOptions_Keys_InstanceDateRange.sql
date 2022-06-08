CREATE FUNCTION [data].[AzureManagedInstance_ConfigurationOptions_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ConfigurationOptions_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ConfigurationOptions_Name]) AS
(
    SELECT [data].[AzureManagedInstance_ConfigurationOptions_Keys].[Id]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[ParentId]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[_Name] AS [AzureManagedInstance_ConfigurationOptions_Name]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_ConfigurationOptions_Keys] ON [data].[AzureManagedInstance_ConfigurationOptions_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_ConfigurationOptions_Keys].[_Name] = @AzureManagedInstance_ConfigurationOptions_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_ConfigurationOptions_Name]
FROM
 [SightedInstances]