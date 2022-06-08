CREATE FUNCTION [data].[AzureSqlServer_Ping_UnstableSamples_Removable]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureSqlServer_Ping_UnstableSamples].[Id], [data].[AzureSqlServer_Ping_UnstableSamples].[CollectionDate]
FROM [data].[AzureSqlServer_Keys]
INNER JOIN [data].[AzureSqlServer_Ping_UnstableSamples] ON [data].[AzureSqlServer_Ping_UnstableSamples].[Id] = [data].[AzureSqlServer_Keys].[Id]
 WHERE  (@AzureSqlServer_Name IS NULL OR [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name)