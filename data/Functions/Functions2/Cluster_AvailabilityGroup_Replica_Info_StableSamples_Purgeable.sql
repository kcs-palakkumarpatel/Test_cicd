CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge stable samples before the last stable sample before the purge date.
SELECT [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples].[Id], [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
            ,
            (
                SELECT TOP 1 [Dates].[CollectionDate]
                FROM [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples] [Dates]
                 WHERE [Dates].[Id] = [SightedIds].[Id]
                 AND [Dates].[CollectionDate] <= @PurgeDate
                ORDER BY [Dates].[CollectionDate] DESC
            )
            AS [LastDate]
        FROM [data].[Cluster_AvailabilityGroup_Replica_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples] ON [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples].[CollectionDate] < [SightedIdsWithLastDates].[LastDate]