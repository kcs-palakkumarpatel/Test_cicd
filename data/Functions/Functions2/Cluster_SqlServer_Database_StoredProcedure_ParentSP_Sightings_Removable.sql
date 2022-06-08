CREATE FUNCTION [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_StoredProcedure_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings].[SightingDate], [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_Keys] ON [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings] ON [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings].[Id] = [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_Database_Name IS NULL OR [data].[Cluster_SqlServer_Database_Keys].[_Name] = @Cluster_SqlServer_Database_Name)
 AND  (@Cluster_SqlServer_Database_StoredProcedure_Name IS NULL OR [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[_Name] = @Cluster_SqlServer_Database_StoredProcedure_Name)
 AND  (@Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent IS NULL OR [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] = @Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent)
 AND  (@Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name IS NULL OR [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] = @Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name)