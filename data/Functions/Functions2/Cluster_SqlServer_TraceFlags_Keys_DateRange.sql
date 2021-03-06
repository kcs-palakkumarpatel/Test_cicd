CREATE FUNCTION [data].[Cluster_SqlServer_TraceFlags_Keys_DateRange]
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
    FROM [data].[Cluster_SqlServer_TraceFlags_Sightings]
    WHERE [data].[Cluster_SqlServer_TraceFlags_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_TraceFlags_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_TraceFlags_TraceFlag]) AS
(
    SELECT [data].[Cluster_SqlServer_TraceFlags_Keys].[Id]
    , [data].[Cluster_SqlServer_TraceFlags_Keys].[ParentId]
    , [data].[Cluster_SqlServer_TraceFlags_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_TraceFlags_Keys].[_TraceFlag] AS [Cluster_SqlServer_TraceFlags_TraceFlag]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_TraceFlags_Keys] ON [data].[Cluster_SqlServer_TraceFlags_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_TraceFlags_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_TraceFlags_TraceFlag]
FROM
 [SightedInstances]