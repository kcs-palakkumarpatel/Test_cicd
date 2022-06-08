CREATE FUNCTION [data].[AzureManagedInstance_SqlText_Instances_DateRange]
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
    FROM [data].[AzureManagedInstance_SqlText_Sightings]
    WHERE [data].[AzureManagedInstance_SqlText_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_SqlText_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_SqlText_SqlHandle]) AS
(
    SELECT [data].[AzureManagedInstance_SqlText_Keys].[Id]
    , [data].[AzureManagedInstance_SqlText_Keys].[ParentId]
    , [data].[AzureManagedInstance_SqlText_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_SqlText_Keys].[_SqlHandle] AS [AzureManagedInstance_SqlText_SqlHandle]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_SqlText_Keys] ON [data].[AzureManagedInstance_SqlText_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_SqlText_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_SqlText_SqlHandle]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_SqlText] AS [AzureManagedInstance_SqlText_SqlText]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_SqlText_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]