CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_TempDB_Files_Sightings]
WHERE [SightingDate] <= @PurgeDate