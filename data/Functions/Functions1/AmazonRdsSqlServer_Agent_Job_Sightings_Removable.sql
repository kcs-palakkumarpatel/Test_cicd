CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Agent_Job_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Agent_Job_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Sightings] ON [data].[AmazonRdsSqlServer_Agent_Job_Sightings].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Agent_Job_Name IS NULL OR [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] = @AmazonRdsSqlServer_Agent_Job_Name)