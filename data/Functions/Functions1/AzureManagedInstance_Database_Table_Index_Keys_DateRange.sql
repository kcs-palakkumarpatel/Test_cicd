CREATE FUNCTION [data].[AzureManagedInstance_Database_Table_Index_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_Table_Index_Sightings]
    WHERE [data].[AzureManagedInstance_Database_Table_Index_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_Table_Index_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_Table_Name], [AzureManagedInstance_Database_Table_Schema], [AzureManagedInstance_Database_Table_Index_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Table_Index_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Table_Index_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Table_Index_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Name] AS [AzureManagedInstance_Database_Table_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Schema] AS [AzureManagedInstance_Database_Table_Schema]
    , [data].[AzureManagedInstance_Database_Table_Index_Keys].[_Name] AS [AzureManagedInstance_Database_Table_Index_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_Table_Index_Keys] ON [data].[AzureManagedInstance_Database_Table_Index_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Database_Table_Keys] ON [data].[AzureManagedInstance_Database_Table_Keys].[Id] = [data].[AzureManagedInstance_Database_Table_Index_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_Table_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_Table_Name]
, [SightedInstances].[AzureManagedInstance_Database_Table_Schema]
, [SightedInstances].[AzureManagedInstance_Database_Table_Index_Name]
FROM
 [SightedInstances]