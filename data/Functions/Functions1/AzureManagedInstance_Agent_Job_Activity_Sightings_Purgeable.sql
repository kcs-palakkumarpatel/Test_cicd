CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_Activity_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AzureManagedInstance_Agent_Job_Activity_Sightings]
WHERE [SightingDate] <= @PurgeDate