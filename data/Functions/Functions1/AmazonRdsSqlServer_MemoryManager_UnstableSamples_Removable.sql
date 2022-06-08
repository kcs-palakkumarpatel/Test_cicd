CREATE FUNCTION [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples].[Id], [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples] ON [data].[AmazonRdsSqlServer_MemoryManager_UnstableSamples].[Id] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)