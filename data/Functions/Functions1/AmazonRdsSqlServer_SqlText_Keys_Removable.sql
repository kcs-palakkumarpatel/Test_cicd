CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlText_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_SqlText_SqlHandle AS VARBINARY(900)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_SqlText_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_SqlText_Keys] ON [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_SqlText_SqlHandle IS NULL OR [data].[AmazonRdsSqlServer_SqlText_Keys].[_SqlHandle] = @AmazonRdsSqlServer_SqlText_SqlHandle)