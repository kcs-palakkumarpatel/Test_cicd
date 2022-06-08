CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Encryption_Key_Id AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Encryption_Key_Type AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys] ON [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Database_Name IS NULL OR [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name)
 AND  (@AmazonRdsSqlServer_Database_Encryption_Key_Id IS NULL OR [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Id] = @AmazonRdsSqlServer_Database_Encryption_Key_Id)
 AND  (@AmazonRdsSqlServer_Database_Encryption_Key_Type IS NULL OR [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Type] = @AmazonRdsSqlServer_Database_Encryption_Key_Type)