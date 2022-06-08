CREATE FUNCTION [data].[AzureManagedInstance_Database_CustomMetric_Sightings_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_CustomMetric_MetricId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_Database_CustomMetric_Sightings].[SightingDate], [data].[AzureManagedInstance_Database_CustomMetric_Sightings].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_CustomMetric_Keys] ON [data].[AzureManagedInstance_Database_CustomMetric_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_Database_CustomMetric_Sightings] ON [data].[AzureManagedInstance_Database_CustomMetric_Sightings].[Id] = [data].[AzureManagedInstance_Database_CustomMetric_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_Database_Name IS NULL OR [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name)
 AND  (@AzureManagedInstance_Database_CustomMetric_MetricId IS NULL OR [data].[AzureManagedInstance_Database_CustomMetric_Keys].[_MetricId] = @AzureManagedInstance_Database_CustomMetric_MetricId)