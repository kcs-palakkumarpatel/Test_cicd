CREATE FUNCTION [data].[Cluster_SqlServer_Services_Sightings_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Services_ServiceName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Services_Sightings].[SightingDate], [data].[Cluster_SqlServer_Services_Sightings].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Services_Keys] ON [data].[Cluster_SqlServer_Services_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Services_Sightings] ON [data].[Cluster_SqlServer_Services_Sightings].[Id] = [data].[Cluster_SqlServer_Services_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_Services_ServiceName IS NULL OR [data].[Cluster_SqlServer_Services_Keys].[_ServiceName] = @Cluster_SqlServer_Services_ServiceName)