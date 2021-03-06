CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Index_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Index_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples] ON [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Schema IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema)
 AND  (@AmazonRdsSqlServer_Database_Table_Index_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Index_Name)