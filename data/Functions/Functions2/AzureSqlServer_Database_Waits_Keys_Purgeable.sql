CREATE FUNCTION [data].[AzureSqlServer_Database_Waits_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AzureSqlServer_Database_Waits_Keys].[Id]
FROM
    [data].[AzureSqlServer_Database_Waits_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AzureSqlServer_Database_Waits_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)