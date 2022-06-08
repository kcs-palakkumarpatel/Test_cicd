CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_TempDB_Files_Sightings]
    WHERE [data].[AzureManagedInstance_TempDB_Files_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TempDB_Files_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TempDB_Files_FileName]) AS
(
    SELECT [data].[AzureManagedInstance_TempDB_Files_Keys].[Id]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] AS [AzureManagedInstance_TempDB_Files_FileName]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_TempDB_Files_Keys] ON [data].[AzureManagedInstance_TempDB_Files_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TempDB_Files_FileName]
FROM
 [SightedInstances]