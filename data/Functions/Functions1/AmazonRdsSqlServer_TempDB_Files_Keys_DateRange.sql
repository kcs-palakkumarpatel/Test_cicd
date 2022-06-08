CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Files_Keys_DateRange]
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
FROM
 [SightedInstances]