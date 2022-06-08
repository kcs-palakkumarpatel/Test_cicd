CREATE FUNCTION [data].[AzureManagedInstance_SqlText_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_SqlText_SqlHandle AS VARBINARY(900)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_SqlText_Sightings].[SightingDate], [data].[AzureManagedInstance_SqlText_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_SqlText_Keys] ON [data].[AzureManagedInstance_SqlText_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_SqlText_Sightings] ON [data].[AzureManagedInstance_SqlText_Sightings].[Id] = [data].[AzureManagedInstance_SqlText_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_SqlText_SqlHandle IS NULL OR [data].[AzureManagedInstance_SqlText_Keys].[_SqlHandle] = @AzureManagedInstance_SqlText_SqlHandle)