CREATE FUNCTION [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Network_TcpEndpoint_EndpointId AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Network_TcpEndpoint_EndpointId]) AS
(
    SELECT [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[Id]
    , [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[_EndpointId] AS [Cluster_SqlServer_Network_TcpEndpoint_EndpointId]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys] ON [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys].[_EndpointId] = @Cluster_SqlServer_Network_TcpEndpoint_EndpointId
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Network_TcpEndpoint_EndpointId]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Active] AS [Cluster_SqlServer_Network_TcpEndpoint_Active]
, [Leaf].[_DynamicPorts] AS [Cluster_SqlServer_Network_TcpEndpoint_DynamicPorts]
, [Leaf].[_Enabled] AS [Cluster_SqlServer_Network_TcpEndpoint_Enabled]
, [Leaf].[_IpAddress] AS [Cluster_SqlServer_Network_TcpEndpoint_IpAddress]
, [Leaf].[_Port] AS [Cluster_SqlServer_Network_TcpEndpoint_Port]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate