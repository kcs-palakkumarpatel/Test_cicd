CREATE FUNCTION [data].[Cluster_SqlServer_Agent_Job_StableSamples_DateRange]
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
    FROM [data].[Cluster_SqlServer_Agent_Job_Sightings]
    WHERE [data].[Cluster_SqlServer_Agent_Job_Sightings].[SightingDate] >= @MinDate AND [data].[Cluster_SqlServer_Agent_Job_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name], [Cluster_SqlServer_Agent_Job_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_Agent_Job_Keys].[Id]
    , [data].[Cluster_SqlServer_Agent_Job_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    , [data].[Cluster_SqlServer_Agent_Job_Keys].[_Name] AS [Cluster_SqlServer_Agent_Job_Name]
    FROM [SightedIds]
     INNER JOIN [data].[Cluster_SqlServer_Agent_Job_Keys] ON [data].[Cluster_SqlServer_Agent_Job_Keys].[Id] = [SightedIds].[Id]
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
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CategoryName] AS [Cluster_SqlServer_Agent_Job_CategoryName]
, [Leaf].[_DatabaseNameOrNone] AS [Cluster_SqlServer_Agent_Job_DatabaseNameOrNone]
, [Leaf].[_DateModified] AS [Cluster_SqlServer_Agent_Job_DateModified]
, [utils].[TicksToDateTime]([Leaf].[_DateModified]) AS [Cluster_SqlServer_Agent_Job_DateModified_DateTime]
, [Leaf].[_Description] AS [Cluster_SqlServer_Agent_Job_Description]
, [Leaf].[_Enabled] AS [Cluster_SqlServer_Agent_Job_Enabled]
, [Leaf].[_JobId] AS [Cluster_SqlServer_Agent_Job_JobId]
, [Leaf].[_Owner] AS [Cluster_SqlServer_Agent_Job_Owner]
, [Leaf].[_OwnerSid] AS [Cluster_SqlServer_Agent_Job_OwnerSid]
, [Leaf].[_VersionNumber] AS [Cluster_SqlServer_Agent_Job_VersionNumber]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_Agent_Job_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_Agent_Job_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate