CREATE FUNCTION [data].[Cluster_ResourceGroup_Resource_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_ResourceGroup_Resource_Sightings]
WHERE [SightingDate] <= @PurgeDate