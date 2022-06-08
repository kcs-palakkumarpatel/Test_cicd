CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AzureManagedInstance_TempDB_Files_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureManagedInstance_TempDB_Files_UnstableSamples] ON [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[CollectionDate] <= @PurgeDate