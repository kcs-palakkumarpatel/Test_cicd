CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_BackupType_Type AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_BackupType_Backup_StartDate AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_BackupType_Type], [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[_Type] AS [AmazonRdsSqlServer_Database_BackupType_Type]
    , [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] AS [AmazonRdsSqlServer_Database_BackupType_Backup_StartDate]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[_Type] = @AmazonRdsSqlServer_Database_BackupType_Type
     AND [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] = @AmazonRdsSqlServer_Database_BackupType_Backup_StartDate
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
FROM
 [SightedInstances]