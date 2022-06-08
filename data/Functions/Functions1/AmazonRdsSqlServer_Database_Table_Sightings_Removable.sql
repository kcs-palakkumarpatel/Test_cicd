CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_Table_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_Database_Table_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Sightings] ON [data].[AmazonRdsSqlServer_Database_Table_Sightings].[Id] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Schema IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema)