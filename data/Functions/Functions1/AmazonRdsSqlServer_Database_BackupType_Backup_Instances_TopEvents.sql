CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_BackupType_Type], [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[_Type] AS [AmazonRdsSqlServer_Database_BackupType_Type]
    , [TopEvents].[_StartDate] AS [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id]
            , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[CollectionDate]
            , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate]
            FROM [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys]
             WHERE [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[Id]
             AND [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] >= @MinDate
             AND [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] <= @MaxDate
            ORDER BY [_StartDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AmazonRdsSqlServer_Name]
, [TopInstances].[AmazonRdsSqlServer_Database_Name]
, [TopInstances].[AmazonRdsSqlServer_Database_BackupType_Type]
, [TopInstances].[AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]
, [utils].[TicksToDateTime]([TopInstances].[AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]) AS [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate_DateTime]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[CollectionDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[CollectionDate]) AS [CollectionDate_DateTime]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_BackupDevice] AS [AmazonRdsSqlServer_Database_BackupType_Backup_BackupDevice]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_BackupSize] AS [AmazonRdsSqlServer_Database_BackupType_Backup_BackupSize]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_DeviceName] AS [AmazonRdsSqlServer_Database_BackupType_Backup_DeviceName]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_FinishDate] AS [AmazonRdsSqlServer_Database_BackupType_Backup_FinishDate]
, [utils].[TicksToDateTime]([data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_FinishDate]) AS [AmazonRdsSqlServer_Database_BackupType_Backup_FinishDate_DateTime]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_IsCompressed] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsCompressed]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_IsCopyOnly] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsCopyOnly]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_IsEncrypted] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsEncrypted]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_IsNativeBackup] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsNativeBackup]
, [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[_IsPasswordProtected] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsPasswordProtected]
FROM [TopInstances]
INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances]
 ON [TopInstances].[Id] = [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances].[Id]