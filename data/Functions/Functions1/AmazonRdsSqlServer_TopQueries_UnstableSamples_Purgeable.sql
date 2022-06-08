CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_TopQueries_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples] ON [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate] <= @PurgeDate