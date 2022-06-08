CREATE FUNCTION [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples].[Id], [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
        FROM [data].[AzureManagedInstance_Database_CustomMetric_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples] ON [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[AzureManagedInstance_Database_CustomMetric_UnstableSamples].[CollectionDate] <= @PurgeDate