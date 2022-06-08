CREATE FUNCTION [data].[AzureManagedInstance_Trace_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Trace_Sightings]
WHERE [SightingDate] <= @PurgeDate