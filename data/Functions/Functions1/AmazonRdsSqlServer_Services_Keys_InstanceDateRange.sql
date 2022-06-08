CREATE FUNCTION [data].[AmazonRdsSqlServer_Services_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Services_ServiceName AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Services_ServiceName]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Services_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Services_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Services_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Services_Keys].[_ServiceName] AS [AmazonRdsSqlServer_Services_ServiceName]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Services_Keys] ON [data].[AmazonRdsSqlServer_Services_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Services_Keys].[_ServiceName] = @AmazonRdsSqlServer_Services_ServiceName
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Services_ServiceName]
FROM
 [SightedInstances]