CREATE FUNCTION [data].[AzureManagedInstance_Services_StableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Services_ServiceName AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Services_ServiceName]) AS
(
    SELECT [data].[AzureManagedInstance_Services_Keys].[Id]
    , [data].[AzureManagedInstance_Services_Keys].[ParentId]
    , [data].[AzureManagedInstance_Services_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Services_Keys].[_ServiceName] AS [AzureManagedInstance_Services_ServiceName]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Services_Keys] ON [data].[AzureManagedInstance_Services_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Services_Keys].[_ServiceName] = @AzureManagedInstance_Services_ServiceName
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Services_ServiceName]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_ServiceState] AS [AzureManagedInstance_Services_ServiceState]
, [Leaf].[_Startup] AS [AzureManagedInstance_Services_Startup]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Services_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Services_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate