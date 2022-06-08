CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_StoredProcedure_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys] ON [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_StoredProcedure_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_StoredProcedure_Keys].[_Name] = @AmazonRdsSqlServer_Database_StoredProcedure_Name)
 AND  (@AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent IS NULL OR [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] = @AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent)
 AND  (@AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] = @AmazonRdsSqlServer_Database_StoredProcedure_ParentSP_Name)