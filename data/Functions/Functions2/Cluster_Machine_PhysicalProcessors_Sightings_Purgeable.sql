﻿CREATE FUNCTION [data].[Cluster_Machine_PhysicalProcessors_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_Machine_PhysicalProcessors_Sightings]
WHERE [SightingDate] <= @PurgeDate