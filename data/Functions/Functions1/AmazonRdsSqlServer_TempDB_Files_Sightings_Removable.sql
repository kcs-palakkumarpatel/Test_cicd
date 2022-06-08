CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Files_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TempDB_Files_FileName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TempDB_Files_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_TempDB_Files_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Files_Keys] ON [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Files_Sightings] ON [data].[AmazonRdsSqlServer_TempDB_Files_Sightings].[Id] = [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_TempDB_Files_FileName IS NULL OR [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[_FileName] = @AmazonRdsSqlServer_TempDB_Files_FileName)