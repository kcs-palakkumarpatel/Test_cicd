CREATE FUNCTION [data].[AzureManagedInstance_Database_BackupType_Backup_Instances_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_BackupType_Type], [AzureManagedInstance_Database_BackupType_Backup_StartDate]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_BackupType_Keys].[_Type] AS [AzureManagedInstance_Database_BackupType_Type]
    , [TopEvents].[_StartDate] AS [AzureManagedInstance_Database_BackupType_Backup_StartDate]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_BackupType_Keys] ON [data].[AzureManagedInstance_Database_BackupType_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[Id]
            , [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[CollectionDate]
            , [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[_StartDate]
            FROM [data].[AzureManagedInstance_Database_BackupType_Backup_Keys]
             WHERE [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[ParentId] = [data].[AzureManagedInstance_Database_BackupType_Keys].[Id]
             AND [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[_StartDate] >= @MinDate
             AND [data].[AzureManagedInstance_Database_BackupType_Backup_Keys].[_StartDate] <= @MaxDate
            ORDER BY [_StartDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AzureManagedInstance_Name]
, [TopInstances].[AzureManagedInstance_Database_Name]
, [TopInstances].[AzureManagedInstance_Database_BackupType_Type]
, [TopInstances].[AzureManagedInstance_Database_BackupType_Backup_StartDate]
, [utils].[TicksToDateTime]([TopInstances].[AzureManagedInstance_Database_BackupType_Backup_StartDate]) AS [AzureManagedInstance_Database_BackupType_Backup_StartDate_DateTime]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[CollectionDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[CollectionDate]) AS [CollectionDate_DateTime]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_BackupDevice] AS [AzureManagedInstance_Database_BackupType_Backup_BackupDevice]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_BackupSize] AS [AzureManagedInstance_Database_BackupType_Backup_BackupSize]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_DeviceName] AS [AzureManagedInstance_Database_BackupType_Backup_DeviceName]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_FinishDate] AS [AzureManagedInstance_Database_BackupType_Backup_FinishDate]
, [utils].[TicksToDateTime]([data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_FinishDate]) AS [AzureManagedInstance_Database_BackupType_Backup_FinishDate_DateTime]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_IsCompressed] AS [AzureManagedInstance_Database_BackupType_Backup_IsCompressed]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_IsCopyOnly] AS [AzureManagedInstance_Database_BackupType_Backup_IsCopyOnly]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_IsEncrypted] AS [AzureManagedInstance_Database_BackupType_Backup_IsEncrypted]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_IsNativeBackup] AS [AzureManagedInstance_Database_BackupType_Backup_IsNativeBackup]
, [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[_IsPasswordProtected] AS [AzureManagedInstance_Database_BackupType_Backup_IsPasswordProtected]
FROM [TopInstances]
INNER JOIN [data].[AzureManagedInstance_Database_BackupType_Backup_Instances]
 ON [TopInstances].[Id] = [data].[AzureManagedInstance_Database_BackupType_Backup_Instances].[Id]