CREATE FUNCTION [data].[AzureManagedInstance_ConfigurationOptions_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_ConfigurationOptions_Sightings]
    WHERE [data].[AzureManagedInstance_ConfigurationOptions_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_ConfigurationOptions_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_ConfigurationOptions_Name]) AS
(
    SELECT [data].[AzureManagedInstance_ConfigurationOptions_Keys].[Id]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[ParentId]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_ConfigurationOptions_Keys].[_Name] AS [AzureManagedInstance_ConfigurationOptions_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_ConfigurationOptions_Keys] ON [data].[AzureManagedInstance_ConfigurationOptions_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_ConfigurationOptions_Keys].[ParentId]
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