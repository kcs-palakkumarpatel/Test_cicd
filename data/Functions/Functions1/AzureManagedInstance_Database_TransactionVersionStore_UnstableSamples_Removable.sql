CREATE FUNCTION [data].[AzureManagedInstance_Database_TransactionVersionStore_UnstableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Database_TransactionVersionStore_UnstableSamples].[Id], [data].[AzureManagedInstance_Database_TransactionVersionStore_UnstableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_TransactionVersionStore_UnstableSamples] ON [data].[AzureManagedInstance_Database_TransactionVersionStore_UnstableSamples].[Id] = [data].[AzureManagedInstance_Database_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Database_Name IS NULL OR [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name)