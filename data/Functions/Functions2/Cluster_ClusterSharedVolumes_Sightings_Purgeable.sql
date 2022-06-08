CREATE FUNCTION [data].[Cluster_ClusterSharedVolumes_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_ClusterSharedVolumes_Sightings]
WHERE [SightingDate] <= @PurgeDate