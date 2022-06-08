CREATE FUNCTION [data].[Cluster_SqlServer_Database_StoredProcedure_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Database_StoredProcedure_Sightings]
WHERE [SightingDate] <= @PurgeDate