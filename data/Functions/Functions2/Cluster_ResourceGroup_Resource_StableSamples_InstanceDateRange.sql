﻿CREATE FUNCTION [data].[Cluster_ResourceGroup_Resource_StableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_ResourceGroup_Name AS NVARCHAR(450)
    , @Cluster_ResourceGroup_Resource_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_ResourceGroup_Name], [Cluster_ResourceGroup_Resource_Name]) AS
(
    SELECT [data].[Cluster_ResourceGroup_Resource_Keys].[Id]
    , [data].[Cluster_ResourceGroup_Resource_Keys].[ParentId]
    , [data].[Cluster_ResourceGroup_Resource_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_ResourceGroup_Keys].[_Name] AS [Cluster_ResourceGroup_Name]
    , [data].[Cluster_ResourceGroup_Resource_Keys].[_Name] AS [Cluster_ResourceGroup_Resource_Name]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_ResourceGroup_Keys] ON [data].[Cluster_ResourceGroup_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
    INNER JOIN [data].[Cluster_ResourceGroup_Resource_Keys] ON [data].[Cluster_ResourceGroup_Resource_Keys].[ParentId] = [data].[Cluster_ResourceGroup_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_ResourceGroup_Keys].[_Name] = @Cluster_ResourceGroup_Name
     AND [data].[Cluster_ResourceGroup_Resource_Keys].[_Name] = @Cluster_ResourceGroup_Resource_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_ResourceGroup_Name]
, [SightedInstances].[Cluster_ResourceGroup_Resource_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Description] AS [Cluster_ResourceGroup_Resource_Description]
, [Leaf].[_State] AS [Cluster_ResourceGroup_Resource_State]
, [Leaf].[_Type] AS [Cluster_ResourceGroup_Resource_Type]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_ResourceGroup_Resource_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_ResourceGroup_Resource_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate