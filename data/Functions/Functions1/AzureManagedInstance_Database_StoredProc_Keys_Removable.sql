CREATE FUNCTION [data].[AzureManagedInstance_Database_StoredProc_Keys_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_StoredProc_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Database_StoredProc_Keys].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_StoredProc_Keys] ON [data].[AzureManagedInstance_Database_StoredProc_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Database_Name IS NULL OR [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name)
 AND  (@AzureManagedInstance_Database_StoredProc_Name IS NULL OR [data].[AzureManagedInstance_Database_StoredProc_Keys].[_Name] = @AzureManagedInstance_Database_StoredProc_Name)