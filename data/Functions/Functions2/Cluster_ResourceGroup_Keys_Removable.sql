CREATE FUNCTION [data].[Cluster_ResourceGroup_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_ResourceGroup_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_ResourceGroup_Keys].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_ResourceGroup_Keys] ON [data].[Cluster_ResourceGroup_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_ResourceGroup_Name IS NULL OR [data].[Cluster_ResourceGroup_Keys].[_Name] = @Cluster_ResourceGroup_Name)