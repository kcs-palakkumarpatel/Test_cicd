﻿CREATE FUNCTION [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[Id]
FROM
    [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AzureManagedInstance_Database_Table_MissingIndex_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)