CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys].[Id]
FROM
    [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys]
WHERE
    [_StartDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)