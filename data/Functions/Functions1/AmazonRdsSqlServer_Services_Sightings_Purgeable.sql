CREATE FUNCTION [data].[AmazonRdsSqlServer_Services_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_Services_Sightings]
WHERE [SightingDate] <= @PurgeDate