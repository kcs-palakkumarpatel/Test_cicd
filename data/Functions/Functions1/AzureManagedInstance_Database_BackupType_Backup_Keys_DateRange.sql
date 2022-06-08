CREATE FUNCTION [data].[AzureManagedInstance_Database_BackupType_Backup_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_BackupType_Backup_Sightings]
    WHERE [data].[AzureManagedInstance_Database_BackupType_Backup_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_BackupType_Backup_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_BackupType_Type], [AzureManagedInstance_Database_BackupType_Backup_StartDate]) AS
(
    SELECT [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[Id]
    , [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_BackupType_Keys].[_Type] AS [AzureManagedInstance_Database_BackupType_Type]
    , [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[_StartDate] AS [AzureManagedInstance_Database_BackupType_Backup_StartDate]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_BackupType_Backup_Keys] ON [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Database_BackupType_Keys] ON [data].[AzureManagedInstance_Database_BackupType_Keys].[Id] = [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_BackupType_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_BackupType_Type]
, [SightedInstances].[AzureManagedInstance_Database_BackupType_Backup_StartDate]
, [utils].[TicksToDateTime]([SightedInstances].[AzureManagedInstance_Database_BackupType_Backup_StartDate]) AS [AzureManagedInstance_Database_BackupType_Backup_StartDate_DateTime]
FROM
 [SightedInstances]