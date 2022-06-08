CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AmazonRdsSqlServer_TempDB_Files_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TempDB_Files_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TempDB_Files_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TempDB_Files_FileName]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[_FileName] AS [AmazonRdsSqlServer_TempDB_Files_FileName]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Files_Keys] ON [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TempDB_Files_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TempDB_Files_FileName]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_FreeBytes] AS [AmazonRdsSqlServer_TempDB_Files_FreeBytes]
, [Leaf].[_InternalBytes] AS [AmazonRdsSqlServer_TempDB_Files_InternalBytes]
, [Leaf].[_MixedBytes] AS [AmazonRdsSqlServer_TempDB_Files_MixedBytes]
, [Leaf].[_UserBytes] AS [AmazonRdsSqlServer_TempDB_Files_UserBytes]
, [Leaf].[_VersionStoreBytes] AS [AmazonRdsSqlServer_TempDB_Files_VersionStoreBytes]
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
    FROM [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]