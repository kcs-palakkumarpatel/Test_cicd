CREATE FUNCTION [data].[AzureSqlServer_Database_TopQueries_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureSqlServer_Database_TopQueries_Sightings]
WHERE [SightingDate] <= @PurgeDate