CREATE FUNCTION [data].[Cluster_Machine_Security_CommunicationProtocol_Keys_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_Machine_Name AS NVARCHAR(450)
    , @Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion]) AS
(
    SELECT [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[Id]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[ParentId]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[_ProtocolVersion] AS [Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_Machine_Security_CommunicationProtocol_Keys] ON [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[ParentId] = [data].[Cluster_Machine_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_Machine_Keys].[_Name] = @Cluster_Machine_Name
     AND [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[_ProtocolVersion] = @Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_Machine_Name]
, [SightedInstances].[Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion]
FROM
 [SightedInstances]