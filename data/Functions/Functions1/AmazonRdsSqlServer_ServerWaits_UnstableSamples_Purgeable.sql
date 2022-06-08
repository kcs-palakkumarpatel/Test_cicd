CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AmazonRdsSqlServer_ServerWaits_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples] ON [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AmazonRdsSqlServer_ServerWaits_UnstableSamples].[CollectionDate] <= @PurgeDate