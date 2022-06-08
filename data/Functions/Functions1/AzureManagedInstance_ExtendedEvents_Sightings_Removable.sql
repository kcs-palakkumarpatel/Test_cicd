CREATE FUNCTION [data].[AzureManagedInstance_ExtendedEvents_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_ExtendedEvents_EventName AS NVARCHAR(450)
    , @AzureManagedInstance_ExtendedEvents_Sequence AS BIGINT
    , @AzureManagedInstance_ExtendedEvents_TimeStamp AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_ExtendedEvents_Sightings].[SightingDate], [data].[AzureManagedInstance_ExtendedEvents_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_ExtendedEvents_Keys] ON [data].[AzureManagedInstance_ExtendedEvents_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_ExtendedEvents_Sightings] ON [data].[AzureManagedInstance_ExtendedEvents_Sightings].[Id] = [data].[AzureManagedInstance_ExtendedEvents_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_ExtendedEvents_EventName IS NULL OR [data].[AzureManagedInstance_ExtendedEvents_Keys].[_EventName] = @AzureManagedInstance_ExtendedEvents_EventName)
 AND  (@AzureManagedInstance_ExtendedEvents_Sequence IS NULL OR [data].[AzureManagedInstance_ExtendedEvents_Keys].[_Sequence] = @AzureManagedInstance_ExtendedEvents_Sequence)
 AND  (@AzureManagedInstance_ExtendedEvents_TimeStamp IS NULL OR [data].[AzureManagedInstance_ExtendedEvents_Keys].[_TimeStamp] = @AzureManagedInstance_ExtendedEvents_TimeStamp)