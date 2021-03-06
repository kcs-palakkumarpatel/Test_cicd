CREATE FUNCTION [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Sightings]
WHERE [SightingDate] <= @PurgeDate