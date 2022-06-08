CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name)
 AND  (@AmazonRdsSqlServer_Database_Table_Schema IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema)
 AND  (@AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns)
 AND  (@AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns)
 AND  (@AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns IS NULL OR [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns)