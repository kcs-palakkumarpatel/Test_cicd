CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_Keys_DateRange]
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
    FROM [data].[AzureManagedInstance_TopQueries_Sightings]
    WHERE [data].[AzureManagedInstance_TopQueries_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_TopQueries_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TopQueries_DatabaseName], [AzureManagedInstance_TopQueries_SqlHandle], [AzureManagedInstance_TopQueries_StatementEnd], [AzureManagedInstance_TopQueries_StatementStart]) AS
(
    SELECT [data].[AzureManagedInstance_TopQueries_Keys].[Id]
    , [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
    , [data].[AzureManagedInstance_TopQueries_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] AS [AzureManagedInstance_TopQueries_DatabaseName]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] AS [AzureManagedInstance_TopQueries_SqlHandle]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] AS [AzureManagedInstance_TopQueries_StatementEnd]
    , [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] AS [AzureManagedInstance_TopQueries_StatementStart]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_TopQueries_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TopQueries_DatabaseName]
, [SightedInstances].[AzureManagedInstance_TopQueries_SqlHandle]
, [SightedInstances].[AzureManagedInstance_TopQueries_StatementEnd]
, [SightedInstances].[AzureManagedInstance_TopQueries_StatementStart]
FROM
 [SightedInstances]