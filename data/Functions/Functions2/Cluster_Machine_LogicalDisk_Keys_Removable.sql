CREATE FUNCTION [data].[Cluster_Machine_LogicalDisk_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_Machine_Name AS NVARCHAR(450)
    , @Cluster_Machine_LogicalDisk_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_Machine_LogicalDisk_Keys].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_Machine_LogicalDisk_Keys] ON [data].[Cluster_Machine_LogicalDisk_Keys].[ParentId] = [data].[Cluster_Machine_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_Machine_Name IS NULL OR [data].[Cluster_Machine_Keys].[_Name] = @Cluster_Machine_Name)
 AND  (@Cluster_Machine_LogicalDisk_Name IS NULL OR [data].[Cluster_Machine_LogicalDisk_Keys].[_Name] = @Cluster_Machine_LogicalDisk_Name)