CREATE FUNCTION [data].[AzureManagedInstance_Error_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Error_LogDate AS BIGINT
    , @AzureManagedInstance_Error_SequenceNumber AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Error_Sightings].[SightingDate], [data].[AzureManagedInstance_Error_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Error_Keys] ON [data].[AzureManagedInstance_Error_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Error_Sightings] ON [data].[AzureManagedInstance_Error_Sightings].[Id] = [data].[AzureManagedInstance_Error_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Error_LogDate IS NULL OR [data].[AzureManagedInstance_Error_Keys].[_LogDate] = @AzureManagedInstance_Error_LogDate)
 AND  (@AzureManagedInstance_Error_SequenceNumber IS NULL OR [data].[AzureManagedInstance_Error_Keys].[_SequenceNumber] = @AzureManagedInstance_Error_SequenceNumber)