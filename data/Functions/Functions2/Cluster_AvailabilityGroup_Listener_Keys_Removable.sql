CREATE FUNCTION [data].[Cluster_AvailabilityGroup_Listener_Keys_Removable]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_AvailabilityGroup_Name AS NVARCHAR(450)
    , @Cluster_AvailabilityGroup_Listener_ListenerDnsName AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[Cluster_AvailabilityGroup_Listener_Keys].[Id]
FROM [data].[Cluster_Keys]
INNER JOIN [data].[Cluster_AvailabilityGroup_Keys] ON [data].[Cluster_AvailabilityGroup_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
INNER JOIN [data].[Cluster_AvailabilityGroup_Listener_Keys] ON [data].[Cluster_AvailabilityGroup_Listener_Keys].[ParentId] = [data].[Cluster_AvailabilityGroup_Keys].[Id]
 WHERE  (@Cluster_Name IS NULL OR [data].[Cluster_Keys].[_Name] = @Cluster_Name)
 AND  (@Cluster_AvailabilityGroup_Name IS NULL OR [data].[Cluster_AvailabilityGroup_Keys].[_Name] = @Cluster_AvailabilityGroup_Name)
 AND  (@Cluster_AvailabilityGroup_Listener_ListenerDnsName IS NULL OR [data].[Cluster_AvailabilityGroup_Listener_Keys].[_ListenerDnsName] = @Cluster_AvailabilityGroup_Listener_ListenerDnsName)