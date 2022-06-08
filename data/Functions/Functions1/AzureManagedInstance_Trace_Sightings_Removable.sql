CREATE FUNCTION [data].[AzureManagedInstance_Trace_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Trace_SequenceNumber AS BIGINT
    , @AzureManagedInstance_Trace_StartTime AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Trace_Sightings].[SightingDate], [data].[AzureManagedInstance_Trace_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Trace_Keys] ON [data].[AzureManagedInstance_Trace_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Trace_Sightings] ON [data].[AzureManagedInstance_Trace_Sightings].[Id] = [data].[AzureManagedInstance_Trace_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Trace_SequenceNumber IS NULL OR [data].[AzureManagedInstance_Trace_Keys].[_SequenceNumber] = @AzureManagedInstance_Trace_SequenceNumber)
 AND  (@AzureManagedInstance_Trace_StartTime IS NULL OR [data].[AzureManagedInstance_Trace_Keys].[_StartTime] = @AzureManagedInstance_Trace_StartTime)