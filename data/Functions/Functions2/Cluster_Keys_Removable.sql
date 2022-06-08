CREATE FUNCTION [data].[Cluster_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_Keys].[Id]
FROM [data].[Cluster_Keys]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)