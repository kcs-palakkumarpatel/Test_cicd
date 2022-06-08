CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge stable samples before the last stable sample before the purge date.
SELECT [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[Id], [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
            ,
            (
                SELECT TOP 1 [Dates].[CollectionDate]
                FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples] [Dates]
                 WHERE [Dates].[Id] = [SightedIds].[Id]
                 AND [Dates].[CollectionDate] <= @PurgeDate
                ORDER BY [Dates].[CollectionDate] DESC
            )
            AS [LastDate]
        FROM [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples] ON [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[CollectionDate] < [SightedIdsWithLastDates].[LastDate]