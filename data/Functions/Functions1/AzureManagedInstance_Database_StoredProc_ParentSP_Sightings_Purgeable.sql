CREATE FUNCTION [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Sightings]
WHERE [SightingDate] <= @PurgeDate