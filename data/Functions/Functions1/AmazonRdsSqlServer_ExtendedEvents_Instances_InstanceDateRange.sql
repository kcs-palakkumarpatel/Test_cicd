CREATE FUNCTION [data].[AmazonRdsSqlServer_ExtendedEvents_Instances_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ExtendedEvents_EventName AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ExtendedEvents_Sequence AS BIGINT
    , @AmazonRdsSqlServer_ExtendedEvents_TimeStamp AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_ExtendedEvents_EventName], [AmazonRdsSqlServer_ExtendedEvents_Sequence], [AmazonRdsSqlServer_ExtendedEvents_TimeStamp]) AS
(
    SELECT [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[Id]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_EventName] AS [AmazonRdsSqlServer_ExtendedEvents_EventName]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_Sequence] AS [AmazonRdsSqlServer_ExtendedEvents_Sequence]
    , [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_TimeStamp] AS [AmazonRdsSqlServer_ExtendedEvents_TimeStamp]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_ExtendedEvents_Keys] ON [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_EventName] = @AmazonRdsSqlServer_ExtendedEvents_EventName
     AND [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_Sequence] = @AmazonRdsSqlServer_ExtendedEvents_Sequence
     AND [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_TimeStamp] = @AmazonRdsSqlServer_ExtendedEvents_TimeStamp
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
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_EventData] AS [AmazonRdsSqlServer_ExtendedEvents_EventData]
, [Leaf].[_FileName] AS [AmazonRdsSqlServer_ExtendedEvents_FileName]
, [Leaf].[_FileOffset] AS [AmazonRdsSqlServer_ExtendedEvents_FileOffset]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_ExtendedEvents_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]