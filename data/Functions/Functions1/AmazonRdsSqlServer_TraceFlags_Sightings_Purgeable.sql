CREATE FUNCTION [data].[AmazonRdsSqlServer_TraceFlags_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_TraceFlags_Sightings]
WHERE [SightingDate] <= @PurgeDate