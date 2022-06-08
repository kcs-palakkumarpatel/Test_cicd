CREATE FUNCTION [data].[AzureSqlServer_ElasticPool_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureSqlServer_ElasticPool_Sightings]
WHERE [SightingDate] <= @PurgeDate