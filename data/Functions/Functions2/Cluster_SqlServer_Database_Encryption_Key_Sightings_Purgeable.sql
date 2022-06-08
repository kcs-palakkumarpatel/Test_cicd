CREATE FUNCTION [data].[Cluster_SqlServer_Database_Encryption_Key_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[Cluster_SqlServer_Database_Encryption_Key_Sightings]
WHERE [SightingDate] <= @PurgeDate