CREATE FUNCTION [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings]
WHERE [SightingDate] <= @PurgeDate