CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_Table_Name], [AmazonRdsSqlServer_Database_Table_Schema], [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Table_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] AS [AmazonRdsSqlServer_Database_Table_Schema]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_Schema]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_AverageCost] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_AverageCost]
, [Leaf].[_AverageImpact] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_AverageImpact]
, [Leaf].[_LastUserScan] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserScan]
, [utils].[TicksToDateTime]([Leaf].[_LastUserScan]) AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserScan_DateTime]
, [Leaf].[_LastUserSeek] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserSeek]
, [utils].[TicksToDateTime]([Leaf].[_LastUserSeek]) AS [AmazonRdsSqlServer_Database_Table_MissingIndex_LastUserSeek_DateTime]
, [Leaf].[_UniqueCompiles] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UniqueCompiles]
, [Leaf].[_UserScans] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UserScans]
, [Leaf].[_UserSeeks] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_UserSeeks]
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
    , [_AverageCost]
    , [_AverageImpact]
    , [_LastUserScan]
    , [_LastUserSeek]
    , [_UniqueCompiles]
    , [_UserScans]
    , [_UserSeeks]
    FROM [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]