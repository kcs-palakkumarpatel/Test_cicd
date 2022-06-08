CREATE FUNCTION [data].[AzureManagedInstance_SqlProcess_Keys_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_SqlProcess_LoginTime AS BIGINT
    , @AzureManagedInstance_SqlProcess_SessionId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_SqlProcess_Keys].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_SqlProcess_Keys] ON [data].[AzureManagedInstance_SqlProcess_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_SqlProcess_LoginTime IS NULL OR [data].[AzureManagedInstance_SqlProcess_Keys].[_LoginTime] = @AzureManagedInstance_SqlProcess_LoginTime)
 AND  (@AzureManagedInstance_SqlProcess_SessionId IS NULL OR [data].[AzureManagedInstance_SqlProcess_Keys].[_SessionId] = @AzureManagedInstance_SqlProcess_SessionId)