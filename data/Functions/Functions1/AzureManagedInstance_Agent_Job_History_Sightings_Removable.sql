CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_History_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Agent_Job_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Agent_Job_History_Id AS BIGINT
    , @AzureManagedInstance_Agent_Job_History_RunDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Agent_Job_History_Sightings].[SightingDate], [data].[AzureManagedInstance_Agent_Job_History_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Agent_Job_History_Keys] ON [data].[AzureManagedInstance_Agent_Job_History_Keys].[ParentId] = [data].[AzureManagedInstance_Agent_Job_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Agent_Job_History_Sightings] ON [data].[AzureManagedInstance_Agent_Job_History_Sightings].[Id] = [data].[AzureManagedInstance_Agent_Job_History_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Agent_Job_Name IS NULL OR [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] = @AzureManagedInstance_Agent_Job_Name)
 AND  (@AzureManagedInstance_Agent_Job_History_Id IS NULL OR [data].[AzureManagedInstance_Agent_Job_History_Keys].[_Id] = @AzureManagedInstance_Agent_Job_History_Id)
 AND  (@AzureManagedInstance_Agent_Job_History_RunDate IS NULL OR [data].[AzureManagedInstance_Agent_Job_History_Keys].[_RunDate] = @AzureManagedInstance_Agent_Job_History_RunDate)