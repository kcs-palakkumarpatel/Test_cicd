CREATE FUNCTION [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge stable samples before the last stable sample before the purge date.
SELECT [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[Id], [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
            ,
            (
                SELECT TOP 1 [Dates].[CollectionDate]
                FROM [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples] [Dates]
                 WHERE [Dates].[Id] = [SightedIds].[Id]
                 AND [Dates].[CollectionDate] <= @PurgeDate
                ORDER BY [Dates].[CollectionDate] DESC
            )
            AS [LastDate]
        FROM [data].[AzureSqlServer_Database_ConfigurationOptions_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples] ON [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[CollectionDate] < [SightedIdsWithLastDates].[LastDate]