CREATE FUNCTION [data].[Cluster_Machine_Process_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_Machine_Process_Sightings]
WHERE [SightingDate] <= @PurgeDate