CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_File_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Database_File_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Database_File_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Database_File_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_File_Name], [AmazonRdsSqlServer_Database_File_Type]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_File_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[_Name] AS [AmazonRdsSqlServer_Database_File_Name]
    , [data].[AmazonRdsSqlServer_Database_File_Keys].[_Type] AS [AmazonRdsSqlServer_Database_File_Type]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_File_Keys] ON [data].[AmazonRdsSqlServer_Database_File_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_File_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
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
FROM
 [SightedInstances]