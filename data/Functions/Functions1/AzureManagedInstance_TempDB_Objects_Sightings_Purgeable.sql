﻿CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Objects_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_TempDB_Objects_Sightings]
WHERE [SightingDate] <= @PurgeDate