CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_TopQueries_Sightings]
WHERE [SightingDate] <= @PurgeDate