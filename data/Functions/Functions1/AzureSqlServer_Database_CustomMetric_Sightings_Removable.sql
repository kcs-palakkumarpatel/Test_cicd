CREATE FUNCTION [data].[AzureSqlServer_Database_CustomMetric_Sightings_Removable]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_CustomMetric_MetricId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureSqlServer_Database_CustomMetric_Sightings].[SightingDate], [data].[AzureSqlServer_Database_CustomMetric_Sightings].[Id]
FROM [data].[AzureSqlServer_Keys]
INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[ParentId] = [data].[AzureSqlServer_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_CustomMetric_Keys] ON [data].[AzureSqlServer_Database_CustomMetric_Keys].[ParentId] = [data].[AzureSqlServer_Database_Keys].[Id]
INNER JOIN [data].[AzureSqlServer_Database_CustomMetric_Sightings] ON [data].[AzureSqlServer_Database_CustomMetric_Sightings].[Id] = [data].[AzureSqlServer_Database_CustomMetric_Keys].[Id]
 WHERE  (@AzureSqlServer_Name IS NULL OR [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name)
 AND  (@AzureSqlServer_Database_Name IS NULL OR [data].[AzureSqlServer_Database_Keys].[_Name] = @AzureSqlServer_Database_Name)
 AND  (@AzureSqlServer_Database_CustomMetric_MetricId IS NULL OR [data].[AzureSqlServer_Database_CustomMetric_Keys].[_MetricId] = @AzureSqlServer_Database_CustomMetric_MetricId)