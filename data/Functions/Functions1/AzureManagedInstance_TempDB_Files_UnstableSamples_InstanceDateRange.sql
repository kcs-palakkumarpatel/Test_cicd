CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_UnstableSamples_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TempDB_Files_FileName AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TempDB_Files_FileName]) AS
(
    SELECT [data].[AzureManagedInstance_TempDB_Files_Keys].[Id]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] AS [AzureManagedInstance_TempDB_Files_FileName]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_TempDB_Files_Keys] ON [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] = @AzureManagedInstance_TempDB_Files_FileName
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TempDB_Files_FileName]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_FreeBytes] AS [AzureManagedInstance_TempDB_Files_FreeBytes]
, [Leaf].[_InternalBytes] AS [AzureManagedInstance_TempDB_Files_InternalBytes]
, [Leaf].[_MixedBytes] AS [AzureManagedInstance_TempDB_Files_MixedBytes]
, [Leaf].[_UserBytes] AS [AzureManagedInstance_TempDB_Files_UserBytes]
, [Leaf].[_VersionStoreBytes] AS [AzureManagedInstance_TempDB_Files_VersionStoreBytes]
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
    , [_FreeBytes]
    , [_InternalBytes]
    , [_MixedBytes]
    , [_UserBytes]
    , [_VersionStoreBytes]
    FROM [data].[AzureManagedInstance_TempDB_Files_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]