CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_SqlProcess_LoginTime AS BIGINT
    , @AmazonRdsSqlServer_SqlProcess_SessionId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_Keys] ON [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples] ON [data].[AmazonRdsSqlServer_SqlProcess_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_SqlProcess_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_SqlProcess_LoginTime IS NULL OR [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] = @AmazonRdsSqlServer_SqlProcess_LoginTime)
 AND  (@AmazonRdsSqlServer_SqlProcess_SessionId IS NULL OR [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] = @AmazonRdsSqlServer_SqlProcess_SessionId)