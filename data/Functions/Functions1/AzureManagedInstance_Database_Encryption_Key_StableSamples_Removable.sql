CREATE FUNCTION [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Encryption_Key_Id AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Encryption_Key_Type AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples].[Id], [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_Encryption_Key_Keys] ON [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples] ON [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples].[Id] = [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Database_Name IS NULL OR [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name)
 AND  (@AzureManagedInstance_Database_Encryption_Key_Id IS NULL OR [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[_Id] = @AzureManagedInstance_Database_Encryption_Key_Id)
 AND  (@AzureManagedInstance_Database_Encryption_Key_Type IS NULL OR [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[_Type] = @AzureManagedInstance_Database_Encryption_Key_Type)