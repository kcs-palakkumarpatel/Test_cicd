CREATE FUNCTION [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

-- Purge stable samples before the last stable sample before the purge date.
SELECT [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples].[Id], [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples].[CollectionDate]
FROM
    (
        -- Only consider ids that have at least one sighting before the purge date.
        SELECT
            [Id]
            ,
            (
                SELECT TOP 1 [Dates].[CollectionDate]
                FROM [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples] [Dates]
                 WHERE [Dates].[Id] = [SightedIds].[Id]
                 AND [Dates].[CollectionDate] <= @PurgeDate
                ORDER BY [Dates].[CollectionDate] DESC
            )
            AS [LastDate]
        FROM [data].[Cluster_SqlServer_ConfigurationOptions_Keys] [SightedIds]
        WHERE [CollectionDate] <= @PurgeDate
        GROUP BY [Id]
    )
    AS [SightedIdsWithLastDates]
INNER JOIN [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples] ON [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples].[Id] = [SightedIdsWithLastDates].[Id]
WHERE [data].[Cluster_SqlServer_ConfigurationOptions_StableSamples].[CollectionDate] < [SightedIdsWithLastDates].[LastDate]