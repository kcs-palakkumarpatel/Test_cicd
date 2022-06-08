CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlText_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_SqlText_Sightings]
WHERE [SightingDate] <= @PurgeDate