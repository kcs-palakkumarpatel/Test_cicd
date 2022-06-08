CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Encryption_Key_Sightings_Purgeable]
(
    @PurgeDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [SightingDate], [Id]
FROM [data].[AmazonRdsSqlServer_Database_Encryption_Key_Sightings]
WHERE [SightingDate] <= @PurgeDate