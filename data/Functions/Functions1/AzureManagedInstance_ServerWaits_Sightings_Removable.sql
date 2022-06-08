CREATE FUNCTION [data].[AzureManagedInstance_ServerWaits_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ServerWaits_WaitType AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_ServerWaits_Sightings].[SightingDate], [data].[AzureManagedInstance_ServerWaits_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_ServerWaits_Keys] ON [data].[AzureManagedInstance_ServerWaits_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_ServerWaits_Sightings] ON [data].[AzureManagedInstance_ServerWaits_Sightings].[Id] = [data].[AzureManagedInstance_ServerWaits_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_ServerWaits_WaitType IS NULL OR [data].[AzureManagedInstance_ServerWaits_Keys].[_WaitType] = @AzureManagedInstance_ServerWaits_WaitType)