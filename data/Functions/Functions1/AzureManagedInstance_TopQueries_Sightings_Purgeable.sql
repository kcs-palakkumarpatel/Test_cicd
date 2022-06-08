CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_TopQueries_Sightings]
WHERE [SightingDate] <= @PurgeDate