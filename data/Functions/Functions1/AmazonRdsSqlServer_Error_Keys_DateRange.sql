CREATE FUNCTION [data].[AmazonRdsSqlServer_Error_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Error_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Error_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Error_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Error_LogDate], [AmazonRdsSqlServer_Error_SequenceNumber]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Error_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Error_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Error_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] AS [AmazonRdsSqlServer_Error_LogDate]
    , [data].[AmazonRdsSqlServer_Error_Keys].[_SequenceNumber] AS [AmazonRdsSqlServer_Error_SequenceNumber]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Error_Keys] ON [data].[AmazonRdsSqlServer_Error_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Error_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Error_LogDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Error_LogDate]) AS [AmazonRdsSqlServer_Error_LogDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Error_SequenceNumber]
FROM
 [SightedInstances]