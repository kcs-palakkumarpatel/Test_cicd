CREATE FUNCTION [data].[AmazonRdsSqlServer_TraceFlags_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TraceFlags_TraceFlag AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TraceFlags_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_TraceFlags_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_TraceFlags_Keys] ON [data].[AmazonRdsSqlServer_TraceFlags_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_TraceFlags_Sightings] ON [data].[AmazonRdsSqlServer_TraceFlags_Sightings].[Id] = [data].[AmazonRdsSqlServer_TraceFlags_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_TraceFlags_TraceFlag IS NULL OR [data].[AmazonRdsSqlServer_TraceFlags_Keys].[_TraceFlag] = @AmazonRdsSqlServer_TraceFlags_TraceFlag)