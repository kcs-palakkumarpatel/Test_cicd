﻿CREATE FUNCTION [data].[Cluster_SqlServer_Database_StoredProcedure_Keys_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Database_StoredProcedure_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Database_Name], [Cluster_SqlServer_Database_StoredProcedure_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[Id]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Database_Keys].[_Name] AS [Cluster_SqlServer_Database_Name]
    , [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[_Name] AS [Cluster_SqlServer_Database_StoredProcedure_Name]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Database_Keys] ON [data].[Cluster_SqlServer_Database_Keys].[ParentId] = [data].[Cluster_SqlServer_Keys].[Id]
    INNER JOIN [data].[Cluster_SqlServer_Database_StoredProcedure_Keys] ON [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[ParentId] = [data].[Cluster_SqlServer_Database_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
     AND [data].[Cluster_SqlServer_Database_Keys].[_Name] = @Cluster_SqlServer_Database_Name
     AND [data].[Cluster_SqlServer_Database_StoredProcedure_Keys].[_Name] = @Cluster_SqlServer_Database_StoredProcedure_Name
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
FROM
 [SightedInstances]