CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Index_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
    , @EventCount AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_Table_Name], [AmazonRdsSqlServer_Database_Table_Schema], [AmazonRdsSqlServer_Database_Table_Index_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Table_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] AS [AmazonRdsSqlServer_Database_Table_Schema]
    , [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Table_Index_Name]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Index_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema
     AND [data].[AmazonRdsSqlServer_Database_Table_Index_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Index_Name
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
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_Index_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Fragmentation] AS [AmazonRdsSqlServer_Database_Table_Index_Fragmentation]
, [Leaf].[_Pages] AS [AmazonRdsSqlServer_Database_Table_Index_Pages]
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
    , [_Fragmentation]
    , [_Pages]
    FROM [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples]
     WHERE [Id] = [SightedInstances].[Id]
     AND [CollectionDate] > [PartitionDates].[PartitionMinDate]
     AND [CollectionDate] <= [PartitionDates].[PartitionMaxDate]
    ORDER BY [CollectionDate] DESC
)
 [Leaf]