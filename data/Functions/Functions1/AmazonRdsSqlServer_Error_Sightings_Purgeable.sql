CREATE FUNCTION [data].[AmazonRdsSqlServer_Error_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_Error_Sightings]
WHERE [SightingDate] <= @PurgeDate