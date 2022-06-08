CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_ServerWaits_Sightings]
WHERE [SightingDate] <= @PurgeDate