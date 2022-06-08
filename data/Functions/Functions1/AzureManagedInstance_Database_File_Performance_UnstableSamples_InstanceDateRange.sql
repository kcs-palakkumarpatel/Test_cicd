﻿CREATE FUNCTION [data].[AzureManagedInstance_Database_File_Performance_UnstableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_File_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_File_Type AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_File_Name], [AzureManagedInstance_Database_File_Type]) AS
(
    SELECT [data].[AzureManagedInstance_Database_File_Keys].[Id]
    , [data].[AzureManagedInstance_Database_File_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_File_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_File_Keys].[_Name] AS [AzureManagedInstance_Database_File_Name]
    , [data].[AzureManagedInstance_Database_File_Keys].[_Type] AS [AzureManagedInstance_Database_File_Type]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_File_Keys] ON [data].[AzureManagedInstance_Database_File_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name
     AND [data].[AzureManagedInstance_Database_File_Keys].[_Name] = @AzureManagedInstance_Database_File_Name
     AND [data].[AzureManagedInstance_Database_File_Keys].[_Type] = @AzureManagedInstance_Database_File_Type
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_File_Name]
, [SightedInstances].[AzureManagedInstance_Database_File_Type]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CumulativeReadBytes] AS [AzureManagedInstance_Database_File_Performance_CumulativeReadBytes]
, [Leaf].[_CumulativeReadStalls] AS [AzureManagedInstance_Database_File_Performance_CumulativeReadStalls]
, [Leaf].[_CumulativeReadStallTime] AS [AzureManagedInstance_Database_File_Performance_CumulativeReadStallTime]
, [Leaf].[_CumulativeWriteBytes] AS [AzureManagedInstance_Database_File_Performance_CumulativeWriteBytes]
, [Leaf].[_CumulativeWriteStalls] AS [AzureManagedInstance_Database_File_Performance_CumulativeWriteStalls]
, [Leaf].[_CumulativeWriteStallTime] AS [AzureManagedInstance_Database_File_Performance_CumulativeWriteStallTime]
FROM
 [SightedInstances]
INNER JOIN
(
    -- We partition the date range into n 'bins' and take the last sample in each bin, if available.
    -- We calculate the bin sizes in floating point to handle ranges of less than n ticks, then round up.
    SELECT
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i]    )) AS [PartitionMinDate],
        (@MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * ([i] + 1)) AS [PartitionMaxDate]
    FROM [utils].[Nat](@MaxSamples)
    WHERE @MinDate + CAST(CEILING(CAST(@MaxDate - @MinDate AS FLOAT) / @MaxSamples) AS BIGINT) * [i] < @MaxDate
)
 [PartitionDates] ON 1 = 1
CROSS APPLY
(
    SELECT TOP (@EventCount)
    [CollectionDate]
    , [_CumulativeReadBytes]
    , [_CumulativeReadStalls]
    , [_CumulativeReadStallTime]
    , [_CumulativeWriteBytes]
    , [_CumulativeWriteStalls]
    , [_CumulativeWriteStallTime]
    FROM [data].[AzureManagedInstance_Database_File_Performance_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]