CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Replica_Database_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_AvailabilityGroup_Replica_Database_Sightings]
WHERE [SightingDate] <= @PurgeDate