﻿CREATE FUNCTION [data].[AzureManagedInstance_Services_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Services_Sightings]
WHERE [SightingDate] <= @PurgeDate