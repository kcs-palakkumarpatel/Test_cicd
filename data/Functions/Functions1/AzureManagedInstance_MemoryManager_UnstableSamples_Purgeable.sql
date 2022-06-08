CREATE FUNCTION [data].[AzureManagedInstance_MemoryManager_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_MemoryManager_UnstableSamples].[Id], [data].[AzureManagedInstance_MemoryManager_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AzureManagedInstance_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureManagedInstance_MemoryManager_UnstableSamples] ON [data].[AzureManagedInstance_MemoryManager_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureManagedInstance_MemoryManager_UnstableSamples].[CollectionDate] <= @PurgeDate