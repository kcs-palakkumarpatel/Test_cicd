CREATE FUNCTION [data].[AzureSqlServer_Database_ExtendedEvents_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureSqlServer_Database_ExtendedEvents_Sightings]
WHERE [SightingDate] <= @PurgeDate