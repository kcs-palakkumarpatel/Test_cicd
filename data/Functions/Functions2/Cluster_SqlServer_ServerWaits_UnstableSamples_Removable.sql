CREATE FUNCTION [data].[Cluster_SqlServer_ServerWaits_UnstableSamples_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_ServerWaits_WaitType AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_ServerWaits_UnstableSamples].[Id], [data].[Cluster_SqlServer_ServerWaits_UnstableSamples].[CollectionDate]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_ServerWaits_Keys] ON [data].[Cluster_SqlServer_ServerWaits_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_ServerWaits_UnstableSamples] ON [data].[Cluster_SqlServer_ServerWaits_UnstableSamples].[Id] = [data].[Cluster_SqlServer_ServerWaits_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_ServerWaits_WaitType IS NULL OR [data].[Cluster_SqlServer_ServerWaits_Keys].[_WaitType] = @Cluster_SqlServer_ServerWaits_WaitType)