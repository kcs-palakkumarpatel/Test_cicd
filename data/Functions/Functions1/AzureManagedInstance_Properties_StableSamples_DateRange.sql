﻿CREATE FUNCTION [data].[AzureManagedInstance_Properties_StableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Sightings]
    WHERE [data].[AzureManagedInstance_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [IdCollectionDate], [AzureManagedInstance_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Keys].[Id]
    , [data].[AzureManagedInstance_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [SightedIds].[Id]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Collation] AS [AzureManagedInstance_Properties_Collation]
, [Leaf].[_Edition] AS [AzureManagedInstance_Properties_Edition]
, [Leaf].[_IsClustered] AS [AzureManagedInstance_Properties_IsClustered]
, [Leaf].[_IsSingleUser] AS [AzureManagedInstance_Properties_IsSingleUser]
, [Leaf].[_IsVirtualMachine] AS [AzureManagedInstance_Properties_IsVirtualMachine]
, [Leaf].[_ProductLevel] AS [AzureManagedInstance_Properties_ProductLevel]
, [Leaf].[_ProductVersion] AS [AzureManagedInstance_Properties_ProductVersion]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Properties_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Properties_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate