CREATE FUNCTION [data].[AmazonRdsSqlServer_ExtendedEvents_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_ExtendedEvents_Sightings]
    WHERE [data].[AmazonRdsSqlServer_ExtendedEvents_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_ExtendedEvents_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_ExtendedEvents_EventName], [AmazonRdsSqlServer_ExtendedEvents_Sequence], [AmazonRdsSqlServer_ExtendedEvents_TimeStamp]) AS
(
    SELECT [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[Id]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_EventName] AS [AmazonRdsSqlServer_ExtendedEvents_EventName]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_Sequence] AS [AmazonRdsSqlServer_ExtendedEvents_Sequence]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_TimeStamp] AS [AmazonRdsSqlServer_ExtendedEvents_TimeStamp]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_ExtendedEvents_Keys] ON [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_ExtendedEvents_EventName]
, [SightedInstances].[AmazonRdsSqlServer_ExtendedEvents_Sequence]
, [SightedInstances].[AmazonRdsSqlServer_ExtendedEvents_TimeStamp]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_ExtendedEvents_TimeStamp]) AS [AmazonRdsSqlServer_ExtendedEvents_TimeStamp_DateTime]
FROM
 [SightedInstances]