CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_BackupType_Type], [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[_Type] AS [AmazonRdsSqlServer_Database_BackupType_Type]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] AS [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_BackupType_Type]
, [SightedInstances].[AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]) AS [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate_DateTime]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_BackupDevice] AS [AmazonRdsSqlServer_Database_BackupType_Backup_BackupDevice]
, [Leaf].[_BackupSize] AS [AmazonRdsSqlServer_Database_BackupType_Backup_BackupSize]
, [Leaf].[_DeviceName] AS [AmazonRdsSqlServer_Database_BackupType_Backup_DeviceName]
, [Leaf].[_FinishDate] AS [AmazonRdsSqlServer_Database_BackupType_Backup_FinishDate]
, [utils].[TicksToDateTime]([Leaf].[_FinishDate]) AS [AmazonRdsSqlServer_Database_BackupType_Backup_FinishDate_DateTime]
, [Leaf].[_IsCompressed] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsCompressed]
, [Leaf].[_IsCopyOnly] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsCopyOnly]
, [Leaf].[_IsEncrypted] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsEncrypted]
, [Leaf].[_IsNativeBackup] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsNativeBackup]
, [Leaf].[_IsPasswordProtected] AS [AmazonRdsSqlServer_Database_BackupType_Backup_IsPasswordProtected]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]