CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ServerWaits_WaitType AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_ServerWaits_WaitType]) AS
(
    SELECT [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_ServerWaits_Keys].[_WaitType] AS [AmazonRdsSqlServer_ServerWaits_WaitType]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_ServerWaits_Keys] ON [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_ServerWaits_Keys].[_WaitType] = @AmazonRdsSqlServer_ServerWaits_WaitType
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_ServerWaits_WaitType]
FROM
 [SightedInstances]