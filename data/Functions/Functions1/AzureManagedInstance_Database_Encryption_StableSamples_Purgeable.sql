CREATE FUNCTION [data].[AzureManagedInstance_Database_Encryption_StableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge stable samples before the last stable sample before the purge date.
SELECT [data].[AzureManagedInstance_Database_Encryption_StableSamples].[Id], [data].[AzureManagedInstance_Database_Encryption_StableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
            ,
            (
                SELECT TOP 1 [Dates].[CollectionDate]
                FROM [data].[AzureManagedInstance_Database_Encryption_StableSamples] [Dates]
                 WHERE [Dates].[Id] = [SightedIds].[Id]
                 AND [Dates].[CollectionDate] <= @PurgeDate
                ORDER BY [Dates].[CollectionDate] DESC
            )
            AS [LastDate]
        FROM [data].[AzureManagedInstance_Database_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureManagedInstance_Database_Encryption_StableSamples] ON [data].[AzureManagedInstance_Database_Encryption_StableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureManagedInstance_Database_Encryption_StableSamples].[CollectionDate] < [SightedIdsWithLastDates].[LastDate]