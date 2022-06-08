CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlText_Instances_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_SqlText_SqlHandle AS VARBINARY(900)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_SqlText_SqlHandle]) AS
(
    SELECT [data].[AmazonRdsSqlServer_SqlText_Keys].[Id]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_SqlText_Keys].[_SqlHandle] AS [AmazonRdsSqlServer_SqlText_SqlHandle]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_SqlText_Keys] ON [data].[AmazonRdsSqlServer_SqlText_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_SqlText_Keys].[_SqlHandle] = @AmazonRdsSqlServer_SqlText_SqlHandle
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_SqlText_SqlHandle]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_SqlText] AS [AmazonRdsSqlServer_SqlText_SqlText]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AmazonRdsSqlServer_SqlText_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]