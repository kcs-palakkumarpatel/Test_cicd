CREATE FUNCTION [data].[AzureManagedInstance_Database_Table_StableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_Table_Sightings]
    WHERE [data].[AzureManagedInstance_Database_Table_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_Table_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_Table_Name], [AzureManagedInstance_Database_Table_Schema]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Table_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Table_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Table_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Name] AS [AzureManagedInstance_Database_Table_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Schema] AS [AzureManagedInstance_Database_Table_Schema]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_Table_Keys] ON [data].[AzureManagedInstance_Database_Table_Keys].[Id] = [SightedIds].[Id]
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
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CreateDate] AS [AzureManagedInstance_Database_Table_CreateDate]
, [utils].[TicksToDateTime]([Leaf].[_CreateDate]) AS [AzureManagedInstance_Database_Table_CreateDate_DateTime]
, [Leaf].[_ModifyDate] AS [AzureManagedInstance_Database_Table_ModifyDate]
, [utils].[TicksToDateTime]([Leaf].[_ModifyDate]) AS [AzureManagedInstance_Database_Table_ModifyDate_DateTime]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Database_Table_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Database_Table_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate