CREATE FUNCTION [data].[AzureManagedInstance_TraceFlags_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_TraceFlags_Sightings]
WHERE [SightingDate] <= @PurgeDate