CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Agent_Job_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Agent_Job_Activity_RunDate AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings].[SightingDate], [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Activity_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[ParentId] = [data].[Cluster_SqlServer_Agent_Job_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings] ON [data].[Cluster_SqlServer_Agent_Job_Activity_Sightings].[Id] = [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_Agent_Job_Name IS NULL OR [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] = @Cluster_SqlServer_Agent_Job_Name)
 AND  (@Cluster_SqlServer_Agent_Job_Activity_RunDate IS NULL OR [data].[Cluster_SqlServer_Agent_Job_Activity_Keys].[_RunDate] = @Cluster_SqlServer_Agent_Job_Activity_RunDate)