CREATE FUNCTION [data].[AmazonRdsSqlServer_Process_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Pid AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Process_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_Process_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Process_UnstableSamples] ON [data].[AmazonRdsSqlServer_Process_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_Process_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Process_Name IS NULL OR [data].[AmazonRdsSqlServer_Process_Keys].[_Name] = @AmazonRdsSqlServer_Process_Name)
 AND  (@AmazonRdsSqlServer_Process_Pid IS NULL OR [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] = @AmazonRdsSqlServer_Process_Pid)