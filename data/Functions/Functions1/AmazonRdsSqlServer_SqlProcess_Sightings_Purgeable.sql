CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlProcess_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_SqlProcess_Sightings]
WHERE [SightingDate] <= @PurgeDate