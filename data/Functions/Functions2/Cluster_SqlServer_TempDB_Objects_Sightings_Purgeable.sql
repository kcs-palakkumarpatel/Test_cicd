CREATE FUNCTION [data].[Cluster_SqlServer_TempDB_Objects_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_TempDB_Objects_Sightings]
WHERE [SightingDate] <= @PurgeDate