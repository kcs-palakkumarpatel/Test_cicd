CREATE FUNCTION [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_CustomMetric_MetricId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples].[Id], [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples].[CollectionDate]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_CustomMetric_Keys] ON [data].[Cluster_SqlServer_Database_CustomMetric_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples] ON [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples].[Id] = [data].[Cluster_SqlServer_Database_CustomMetric_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_Database_Name IS NULL OR [data].[Cluster_SqlServer_Database_Keys].[_Name] = @Cluster_SqlServer_Database_Name)
 AND  (@Cluster_SqlServer_Database_CustomMetric_MetricId IS NULL OR [data].[Cluster_SqlServer_Database_CustomMetric_Keys].[_MetricId] = @Cluster_SqlServer_Database_CustomMetric_MetricId)