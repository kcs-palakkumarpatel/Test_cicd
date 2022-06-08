CREATE FUNCTION [data].[AzureManagedInstance_ConfigurationOptions_Keys_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ConfigurationOptions_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_ConfigurationOptions_Keys].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_ConfigurationOptions_Keys] ON [data].[AzureManagedInstance_ConfigurationOptions_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_ConfigurationOptions_Name IS NULL OR [data].[AzureManagedInstance_ConfigurationOptions_Keys].[_Name] = @AzureManagedInstance_ConfigurationOptions_Name)