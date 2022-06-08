CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_File_StableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_File_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_File_Type AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_File_Name], [AmazonRdsSqlServer_Database_File_Type]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_File_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[_Name] AS [AmazonRdsSqlServer_Database_File_Name]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[_Type] AS [AmazonRdsSqlServer_Database_File_Type]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_File_Keys] ON [data].[AmazonRdsSqlServer_Database_File_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_File_Keys].[_Name] = @AmazonRdsSqlServer_Database_File_Name
     AND [data].[AmazonRdsSqlServer_Database_File_Keys].[_Type] = @AmazonRdsSqlServer_Database_File_Type
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_File_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_File_Type]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_FileGroupName] AS [AmazonRdsSqlServer_Database_File_FileGroupName]
, [Leaf].[_FileName] AS [AmazonRdsSqlServer_Database_File_FileName]
, [Leaf].[_GrowthBytes] AS [AmazonRdsSqlServer_Database_File_GrowthBytes]
, [Leaf].[_GrowthPercent] AS [AmazonRdsSqlServer_Database_File_GrowthPercent]
, [Leaf].[_MaxSize] AS [AmazonRdsSqlServer_Database_File_MaxSize]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AmazonRdsSqlServer_Database_File_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AmazonRdsSqlServer_Database_File_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate