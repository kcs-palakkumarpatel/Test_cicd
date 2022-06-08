CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_ServerWaits_Sightings]
WHERE [SightingDate] <= @PurgeDate