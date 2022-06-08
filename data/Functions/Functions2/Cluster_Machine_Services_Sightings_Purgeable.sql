CREATE FUNCTION [data].[Cluster_Machine_Services_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_Machine_Services_Sightings]
WHERE [SightingDate] <= @PurgeDate