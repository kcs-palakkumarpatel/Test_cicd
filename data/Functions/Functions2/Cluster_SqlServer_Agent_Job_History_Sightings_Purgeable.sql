CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_History_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Agent_Job_History_Sightings]
WHERE [SightingDate] <= @PurgeDate