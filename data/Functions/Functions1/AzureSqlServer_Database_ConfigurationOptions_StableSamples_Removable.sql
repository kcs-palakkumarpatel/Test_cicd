CREATE FUNCTION [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples_Removable]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_ConfigurationOptions_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[Id], [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[CollectionDate]
FROM [data].[AzureSqlServer_Keys]
INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[ParentId] = [data].[AzureSqlServer_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_ConfigurationOptions_Keys] ON [data].[AzureSqlServer_Database_ConfigurationOptions_Keys].[ParentId] = [data].[AzureSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples] ON [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples].[Id] = [data].[AzureSqlServer_Database_ConfigurationOptions_Keys].[Id]
 WHERE  (@AzureSqlServer_Name IS NULL OR [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name)
 AND  (@AzureSqlServer_Database_Name IS NULL OR [data].[AzureSqlServer_Database_Keys].[_Name] = @AzureSqlServer_Database_Name)
 AND  (@AzureSqlServer_Database_ConfigurationOptions_Name IS NULL OR [data].[AzureSqlServer_Database_ConfigurationOptions_Keys].[_Name] = @AzureSqlServer_Database_ConfigurationOptions_Name)