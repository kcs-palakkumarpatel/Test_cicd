CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Objects_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AzureManagedInstance_TempDB_Objects_Keys].[Id]
FROM
    [data].[AzureManagedInstance_TempDB_Objects_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AzureManagedInstance_TempDB_Objects_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)