﻿CREATE FUNCTION [data].[AzureManagedInstance_Database_Table_Index_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Database_Table_Index_Sightings]
WHERE [SightingDate] <= @PurgeDate