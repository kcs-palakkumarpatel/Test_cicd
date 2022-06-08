CREATE FUNCTION [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys_DateRange]
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
    FROM [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings]
    WHERE [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Database_Name], [Cluster_SqlServer_Database_StoredProcedure_Name], [Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent], [Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[Id]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[_Name] AS [Cluster_SqlServer_Database_StoredProcedure_Name]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] AS [Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] AS [Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_Keys] ON [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[Id] = [data].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId]
     INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[Id] = [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[ParentId]
     INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Database_Keys].[ParentId]
     INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [SightedInstances].[Cluster_SqlServer_Database_Name]
, [SightedInstances].[Cluster_SqlServer_Database_StoredProcedure_Name]
, [SightedInstances].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent]
, [SightedInstances].[Cluster_SqlServer_Database_StoredProcedure_ParentSP_Name]
FROM
 [SightedInstances]