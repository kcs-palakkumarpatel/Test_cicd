CREATE FUNCTION [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples].[Id], [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[Cluster_SqlServer_Database_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples] ON [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[Cluster_SqlServer_Database_TransactionVersionStore_UnstableSamples].[CollectionDate] <= @PurgeDate