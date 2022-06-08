CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Listener_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_AvailabilityGroup_Listener_Sightings]
WHERE [SightingDate] <= @PurgeDate