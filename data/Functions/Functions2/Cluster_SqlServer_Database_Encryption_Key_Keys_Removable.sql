CREATE FUNCTION [data].[Cluster_SqlServer_Database_Encryption_Key_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Encryption_Key_Id AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Encryption_Key_Type AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
INNER JOIN [data].[Cluster_SqlServer_Database_Encryption_Key_Keys] ON [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_SqlServer_Name IS NULL OR [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name)
 AND  (@Cluster_SqlServer_Database_Name IS NULL OR [data].[Cluster_SqlServer_Database_Keys].[_Name] = @Cluster_SqlServer_Database_Name)
 AND  (@Cluster_SqlServer_Database_Encryption_Key_Id IS NULL OR [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[_Id] = @Cluster_SqlServer_Database_Encryption_Key_Id)
 AND  (@Cluster_SqlServer_Database_Encryption_Key_Type IS NULL OR [data].[Cluster_SqlServer_Database_Encryption_Key_Keys].[_Type] = @Cluster_SqlServer_Database_Encryption_Key_Type)