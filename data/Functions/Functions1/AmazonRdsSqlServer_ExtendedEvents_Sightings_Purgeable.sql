CREATE FUNCTION [data].[AmazonRdsSqlServer_ExtendedEvents_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_ExtendedEvents_Sightings]
WHERE [SightingDate] <= @PurgeDate