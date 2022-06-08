CREATE FUNCTION [data].[AzureManagedInstance_Error_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AzureManagedInstance_Error_Keys].[Id]
FROM
    [data].[AzureManagedInstance_Error_Keys]
WHERE
    [_LogDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AzureManagedInstance_Error_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)