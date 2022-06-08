CREATE FUNCTION [data].[Cluster_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_Sightings]
WHERE [SightingDate] <= @PurgeDate