CREATE FUNCTION [data].[Cluster_SqlServer_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Keys].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)