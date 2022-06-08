CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_Instances_DateRange]
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
    FROM [data].[AmazonRdsSqlServer_Agent_Job_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Agent_Job_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Agent_Job_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_DateCreated] AS [AmazonRdsSqlServer_Agent_Job_DateCreated]
, [utils].[TicksToDateTime]([Leaf].[_DateCreated]) AS [AmazonRdsSqlServer_Agent_Job_DateCreated_DateTime]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_Agent_Job_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]