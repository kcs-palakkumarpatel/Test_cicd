﻿CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_Database_Table_Sightings]
WHERE [SightingDate] <= @PurgeDate