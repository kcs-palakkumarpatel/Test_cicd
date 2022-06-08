CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[CollectionDate] <= @PurgeDate