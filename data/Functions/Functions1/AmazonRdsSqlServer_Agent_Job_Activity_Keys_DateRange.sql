CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Agent_Job_Activity_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Agent_Job_Activity_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Agent_Job_Activity_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name], [AmazonRdsSqlServer_Agent_Job_Activity_RunDate]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[_RunDate] AS [AmazonRdsSqlServer_Agent_Job_Activity_RunDate]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_Activity_RunDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Agent_Job_Activity_RunDate]) AS [AmazonRdsSqlServer_Agent_Job_Activity_RunDate_DateTime]
FROM
 [SightedInstances]