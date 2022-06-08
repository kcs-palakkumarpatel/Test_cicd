CREATE FUNCTION [data].[AzureManagedInstance_Error_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Error_Sightings]
WHERE [SightingDate] <= @PurgeDate