CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TempDB_Objects_TempTableName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings].[SightingDate], [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Objects_Keys] ON [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings] ON [data].[AmazonRdsSqlServer_TempDB_Objects_Sightings].[Id] = [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_TempDB_Objects_TempTableName IS NULL OR [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[_TempTableName] = @AmazonRdsSqlServer_TempDB_Objects_TempTableName)