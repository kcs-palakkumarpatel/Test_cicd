CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AzureManagedInstance_SqlProcess_Keys].[Id]
FROM
    [data].[AzureManagedInstance_SqlProcess_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AzureManagedInstance_SqlProcess_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)