CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_SqlProcess_Sightings]
WHERE [SightingDate] <= @PurgeDate