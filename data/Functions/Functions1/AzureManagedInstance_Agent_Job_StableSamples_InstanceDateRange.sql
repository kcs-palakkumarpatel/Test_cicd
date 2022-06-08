﻿CREATE FUNCTION [data].[AzureManagedInstance_Agent_Job_StableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Agent_Job_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Agent_Job_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Agent_Job_Keys].[Id]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] AS [AzureManagedInstance_Agent_Job_Name]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Agent_Job_Keys] ON [data].[AzureManagedInstance_Agent_Job_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Agent_Job_Keys].[_Name] = @AzureManagedInstance_Agent_Job_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Agent_Job_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CategoryName] AS [AzureManagedInstance_Agent_Job_CategoryName]
, [Leaf].[_DatabaseNameOrNone] AS [AzureManagedInstance_Agent_Job_DatabaseNameOrNone]
, [Leaf].[_DateModified] AS [AzureManagedInstance_Agent_Job_DateModified]
, [utils].[TicksToDateTime]([Leaf].[_DateModified]) AS [AzureManagedInstance_Agent_Job_DateModified_DateTime]
, [Leaf].[_Description] AS [AzureManagedInstance_Agent_Job_Description]
, [Leaf].[_Enabled] AS [AzureManagedInstance_Agent_Job_Enabled]
, [Leaf].[_Owner] AS [AzureManagedInstance_Agent_Job_Owner]
, [Leaf].[_OwnerSid] AS [AzureManagedInstance_Agent_Job_OwnerSid]
, [Leaf].[_VersionNumber] AS [AzureManagedInstance_Agent_Job_VersionNumber]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Agent_Job_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Agent_Job_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate