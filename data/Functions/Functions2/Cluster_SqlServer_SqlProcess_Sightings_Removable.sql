CREATE FUNCTION [data].[Cluster_SqlServer_SqlProcess_Sightings_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_SqlProcess_LoginTime AS BIGINT
    , @Cluster_SqlServer_SqlProcess_SessionId AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_SqlProcess_Sightings].[SightingDate], [data].[Cluster_SqlServer_SqlProcess_Sightings].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_SqlProcess_Keys] ON [data].[Cluster_SqlServer_SqlProcess_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_SqlProcess_Sightings] ON [data].[Cluster_SqlServer_SqlProcess_Sightings].[Id] = [data].[Cluster_SqlServer_SqlProcess_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_SqlProcess_LoginTime IS NULL OR [data].[Cluster_SqlServer_SqlProcess_Keys].[_LoginTime] = @Cluster_SqlServer_SqlProcess_LoginTime)
 AND  (@Cluster_SqlServer_SqlProcess_SessionId IS NULL OR [data].[Cluster_SqlServer_SqlProcess_Keys].[_SessionId] = @Cluster_SqlServer_SqlProcess_SessionId)