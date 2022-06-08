CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_CustomMetric_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[AmazonRdsSqlServer_Database_CustomMetric_Keys].[Id]
FROM
    [data].[AmazonRdsSqlServer_Database_CustomMetric_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[AmazonRdsSqlServer_Database_CustomMetric_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)