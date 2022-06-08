CREATE FUNCTION [data].[Cluster_SqlServer_QueryPlans_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_QueryPlans_Sightings]
WHERE [SightingDate] <= @PurgeDate