CREATE FUNCTION [data].[AzureManagedInstance_SqlText_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_SqlText_Sightings]
WHERE [SightingDate] <= @PurgeDate