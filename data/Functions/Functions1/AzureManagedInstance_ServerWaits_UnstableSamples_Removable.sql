CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_UnstableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ServerWaits_WaitType AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id], [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_ServerWaits_UnstableSamples] ON [data].[AzureManagedInstance_ServerWaits_UnstableSamples].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_ServerWaits_WaitType IS NULL OR [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] = @AzureManagedInstance_ServerWaits_WaitType)