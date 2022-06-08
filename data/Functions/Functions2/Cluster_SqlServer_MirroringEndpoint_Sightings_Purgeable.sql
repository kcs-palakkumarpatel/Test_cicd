CREATE FUNCTION [data].[Cluster_SqlServer_MirroringEndpoint_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_MirroringEndpoint_Sightings]
WHERE [SightingDate] <= @PurgeDate