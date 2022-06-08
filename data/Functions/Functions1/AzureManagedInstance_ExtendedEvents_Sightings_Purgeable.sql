CREATE FUNCTION [data].[AzureManagedInstance_ExtendedEvents_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_ExtendedEvents_Sightings]
WHERE [SightingDate] <= @PurgeDate