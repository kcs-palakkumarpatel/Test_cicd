CREATE FUNCTION [data].[AmazonRdsSqlServer_Process_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Pid AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Process_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Process_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Process_Sightings] ON [data].[AmazonRdsSqlServer_Process_Sightings].[Id] = [data].[AmazonRdsSqlServer_Process_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Process_Name IS NULL OR [data].[AmazonRdsSqlServer_Process_Keys].[_Name] = @AmazonRdsSqlServer_Process_Name)
 AND  (@AmazonRdsSqlServer_Process_Pid IS NULL OR [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] = @AmazonRdsSqlServer_Process_Pid)