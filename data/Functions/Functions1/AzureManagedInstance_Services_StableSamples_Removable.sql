CREATE FUNCTION [data].[AzureManagedInstance_Services_StableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Services_ServiceName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Services_StableSamples].[Id], [data].[AzureManagedInstance_Services_StableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Services_Keys] ON [data].[AzureManagedInstance_Services_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Services_StableSamples] ON [data].[AzureManagedInstance_Services_StableSamples].[Id] = [data].[AzureManagedInstance_Services_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Services_ServiceName IS NULL OR [data].[AzureManagedInstance_Services_Keys].[_ServiceName] = @AzureManagedInstance_Services_ServiceName)