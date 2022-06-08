CREATE FUNCTION [data].[AmazonRdsSqlServer_TraceFlags_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_TraceFlags_Sightings]
    WHERE [data].[AmazonRdsSqlServer_TraceFlags_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_TraceFlags_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TraceFlags_TraceFlag]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TraceFlags_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[_TraceFlag] AS [AmazonRdsSqlServer_TraceFlags_TraceFlag]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_TraceFlags_Keys] ON [data].[AmazonRdsSqlServer_TraceFlags_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_TraceFlags_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TraceFlags_TraceFlag]
FROM
 [SightedInstances]