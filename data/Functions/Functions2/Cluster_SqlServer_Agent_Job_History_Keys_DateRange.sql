CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_History_Keys_DateRange]
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
    FROM [data].[Cluster_SqlServer_Agent_Job_History_Sightings]
    WHERE [data].[Cluster_SqlServer_Agent_Job_History_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_Agent_Job_History_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Agent_Job_Name], [Cluster_SqlServer_Agent_Job_History_Id], [Cluster_SqlServer_Agent_Job_History_RunDate]) AS
(
    SELECT [data].[Cluster_SqlServer_Agent_Job_History_Keys].[Id]
    , [data].[Cluster_SqlServer_Agent_Job_History_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Agent_Job_History_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] AS [Cluster_SqlServer_Agent_Job_Name]
    , [data].[Cluster_SqlServer_Agent_Job_History_Keys].[_Id] AS [Cluster_SqlServer_Agent_Job_History_Id]
    , [data].[Cluster_SqlServer_Agent_Job_History_Keys].[_RunDate] AS [Cluster_SqlServer_Agent_Job_History_RunDate]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_Agent_Job_History_Keys] ON [data].[Cluster_SqlServer_Agent_Job_History_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Keys].[Id] = [data].[Cluster_SqlServer_Agent_Job_History_Keys].[ParentId]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Agent_Job_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Agent_Job_Name]
, [SightedInstances].[Cluster_SqlServer_Agent_Job_History_Id]
, [SightedInstances].[Cluster_SqlServer_Agent_Job_History_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[Cluster_SqlServer_Agent_Job_History_RunDate]) AS [Cluster_SqlServer_Agent_Job_History_RunDate_DateTime]
FROM
 [SightedInstances]