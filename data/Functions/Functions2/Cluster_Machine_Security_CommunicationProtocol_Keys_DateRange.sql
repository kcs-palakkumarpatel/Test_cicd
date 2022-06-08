CREATE FUNCTION [data].[Cluster_Machine_Security_CommunicationProtocol_Keys_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[Cluster_Machine_Security_CommunicationProtocol_Sightings]
    WHERE [data].[Cluster_Machine_Security_CommunicationProtocol_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_Machine_Security_CommunicationProtocol_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_Machine_Name], [Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion]) AS
(
    SELECT [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[Id]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[ParentId]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_Machine_Keys].[_Name] AS [Cluster_Machine_Name]
    , [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[_ProtocolVersion] AS [Cluster_Machine_Security_CommunicationProtocol_ProtocolVersion]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_Machine_Security_CommunicationProtocol_Keys] ON [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_Machine_Keys] ON [data].[Cluster_Machine_Keys].[Id] = [data].[Cluster_Machine_Security_CommunicationProtocol_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_Machine_Keys].[ParentId]
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