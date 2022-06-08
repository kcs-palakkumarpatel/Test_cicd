CREATE FUNCTION [data].[AmazonRdsSqlServer_Process_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Pid AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Process_Name], [AmazonRdsSqlServer_Process_Pid]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Process_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Process_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Process_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Name] AS [AmazonRdsSqlServer_Process_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] AS [AmazonRdsSqlServer_Process_Pid]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Process_Keys].[_Name] = @AmazonRdsSqlServer_Process_Name
     AND [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] = @AmazonRdsSqlServer_Process_Pid
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Pid]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_PercentageCpuUsed] AS [AmazonRdsSqlServer_Process_PercentageCpuUsed]
, [Leaf].[_PercentageMemoryUsed] AS [AmazonRdsSqlServer_Process_PercentageMemoryUsed]
, [Leaf].[_PrivateSetKilobytes] AS [AmazonRdsSqlServer_Process_PrivateSetKilobytes]
, [Leaf].[_ShareableSetKilobytes] AS [AmazonRdsSqlServer_Process_ShareableSetKilobytes]
, [Leaf].[_VirtualKilobytes] AS [AmazonRdsSqlServer_Process_VirtualKilobytes]
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
    , [_PercentageCpuUsed]
    , [_PercentageMemoryUsed]
    , [_PrivateSetKilobytes]
    , [_ShareableSetKilobytes]
    , [_VirtualKilobytes]
    FROM [data].[AmazonRdsSqlServer_Process_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]