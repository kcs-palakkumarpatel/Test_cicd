CREATE FUNCTION [data].[AzureManagedInstance_Database_BackupType_Backup_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Database_BackupType_Backup_Sightings]
WHERE [SightingDate] <= @PurgeDate