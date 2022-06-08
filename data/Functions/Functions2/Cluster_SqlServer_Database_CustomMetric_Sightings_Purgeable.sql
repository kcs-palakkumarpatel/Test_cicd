﻿CREATE FUNCTION [data].[Cluster_SqlServer_Database_CustomMetric_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Database_CustomMetric_Sightings]
WHERE [SightingDate] <= @PurgeDate