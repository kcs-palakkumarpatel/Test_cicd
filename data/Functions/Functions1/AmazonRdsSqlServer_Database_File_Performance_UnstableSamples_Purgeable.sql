CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_Database_File_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples] ON [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_Database_File_Performance_UnstableSamples].[CollectionDate] <= @PurgeDate