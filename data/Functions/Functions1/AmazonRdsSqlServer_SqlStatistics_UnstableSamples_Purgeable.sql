CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples].[CollectionDate]
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
INNER JOIN [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples] ON [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_SqlStatistics_UnstableSamples].[CollectionDate] <= @PurgeDate