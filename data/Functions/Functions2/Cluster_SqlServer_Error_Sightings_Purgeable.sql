CREATE FUNCTION [data].[Cluster_SqlServer_Error_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Error_Sightings]
WHERE [SightingDate] <= @PurgeDate