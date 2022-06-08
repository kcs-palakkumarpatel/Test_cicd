CREATE FUNCTION [data].[AzureManagedInstance_Database_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Database_Sightings]
WHERE [SightingDate] <= @PurgeDate