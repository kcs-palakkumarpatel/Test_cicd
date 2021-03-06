CREATE FUNCTION [data].[AzureManagedInstance_TraceFlags_Keys_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TraceFlags_TraceFlag AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_TraceFlags_Keys].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_TraceFlags_Keys] ON [data].[AzureManagedInstance_TraceFlags_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_TraceFlags_TraceFlag IS NULL OR [data].[AzureManagedInstance_TraceFlags_Keys].[_TraceFlag] = @AzureManagedInstance_TraceFlags_TraceFlag)