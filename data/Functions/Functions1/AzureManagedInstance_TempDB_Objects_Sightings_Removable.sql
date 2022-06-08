CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Objects_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TempDB_Objects_TempTableName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_TempDB_Objects_Sightings].[SightingDate], [data].[AzureManagedInstance_TempDB_Objects_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_TempDB_Objects_Keys] ON [data].[AzureManagedInstance_TempDB_Objects_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_TempDB_Objects_Sightings] ON [data].[AzureManagedInstance_TempDB_Objects_Sightings].[Id] = [data].[AzureManagedInstance_TempDB_Objects_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_TempDB_Objects_TempTableName IS NULL OR [data].[AzureManagedInstance_TempDB_Objects_Keys].[_TempTableName] = @AzureManagedInstance_TempDB_Objects_TempTableName)