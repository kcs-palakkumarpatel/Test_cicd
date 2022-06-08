CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_Database_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples] ON [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_Database_TransactionVersionStore_UnstableSamples].[CollectionDate] <= @PurgeDate