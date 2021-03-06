CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples].[Id], [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[Cluster_AvailabilityGroup_Replica_Database_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples] ON [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples].[CollectionDate] <= @PurgeDate