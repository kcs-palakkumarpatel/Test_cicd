CREATE FUNCTION [data].[AmazonRdsSqlServer_Process_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Process_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Process_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Process_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Process_Name], [AmazonRdsSqlServer_Process_Pid]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Process_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Process_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Process_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Name] AS [AmazonRdsSqlServer_Process_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] AS [AmazonRdsSqlServer_Process_Pid]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Process_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Pid]
FROM
 [SightedInstances]