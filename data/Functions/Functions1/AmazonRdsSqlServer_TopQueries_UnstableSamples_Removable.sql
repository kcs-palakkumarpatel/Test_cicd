CREATE FUNCTION [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_DatabaseName AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TopQueries_SqlHandle AS VARBINARY(900)
    , @AmazonRdsSqlServer_TopQueries_StatementEnd AS BIGINT
    , @AmazonRdsSqlServer_TopQueries_StatementStart AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_Keys] ON [data].[AmazonRdsSqlServer_TopQueries_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples] ON [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_TopQueries_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_TopQueries_DatabaseName IS NULL OR [data].[AmazonRdsSqlServer_TopQueries_Keys].[_DatabaseName] = @AmazonRdsSqlServer_TopQueries_DatabaseName)
 AND  (@AmazonRdsSqlServer_TopQueries_SqlHandle IS NULL OR [data].[AmazonRdsSqlServer_TopQueries_Keys].[_SqlHandle] = @AmazonRdsSqlServer_TopQueries_SqlHandle)
 AND  (@AmazonRdsSqlServer_TopQueries_StatementEnd IS NULL OR [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementEnd] = @AmazonRdsSqlServer_TopQueries_StatementEnd)
 AND  (@AmazonRdsSqlServer_TopQueries_StatementStart IS NULL OR [data].[AmazonRdsSqlServer_TopQueries_Keys].[_StatementStart] = @AmazonRdsSqlServer_TopQueries_StatementStart)