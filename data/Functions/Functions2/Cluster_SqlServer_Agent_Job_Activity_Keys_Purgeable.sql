CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_Activity_Keys_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge all rows of all ids that have not been sighted after the purge date.
-- The cascade will handle the leaf tables for us.
SELECT
    [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[Id]
FROM
    [data].[Cluster_SqlServer_Agent_Job_Activity_Keys]
WHERE
    [CollectionDate] <= @PurgeDate
    AND [Id] NOT IN 
(
    SELECT
        [Id]
    FROM
        [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings]
    WHERE
        [SightingDate] > @PurgeDate
)