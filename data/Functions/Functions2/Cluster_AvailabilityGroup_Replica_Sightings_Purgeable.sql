CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Replica_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_AvailabilityGroup_Replica_Sightings]
WHERE [SightingDate] <= @PurgeDate