CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_BackupType_Type AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_BackupType_Backup_StartDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys] ON [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_BackupType_Type IS NULL OR [data].[AmazonRdsSqlServer_Database_BackupType_Keys].[_Type] = @AmazonRdsSqlServer_Database_BackupType_Type)
 AND  (@AmazonRdsSqlServer_Database_BackupType_Backup_StartDate IS NULL OR [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[_StartDate] = @AmazonRdsSqlServer_Database_BackupType_Backup_StartDate)