CREATE FUNCTION [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples] ON [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples].[CollectionDate] <= @PurgeDate