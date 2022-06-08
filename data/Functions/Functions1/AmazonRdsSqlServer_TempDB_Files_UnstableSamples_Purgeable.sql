CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_TempDB_Files_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples] ON [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples].[CollectionDate] <= @PurgeDate