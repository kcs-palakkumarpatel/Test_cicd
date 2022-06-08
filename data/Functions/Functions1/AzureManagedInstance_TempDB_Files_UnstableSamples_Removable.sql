CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_UnstableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TempDB_Files_FileName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id], [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_TempDB_Files_Keys] ON [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_TempDB_Files_UnstableSamples] ON [data].[AzureManagedInstance_TempDB_Files_UnstableSamples].[Id] = [data].[AzureManagedInstance_TempDB_Files_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_TempDB_Files_FileName IS NULL OR [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] = @AzureManagedInstance_TempDB_Files_FileName)