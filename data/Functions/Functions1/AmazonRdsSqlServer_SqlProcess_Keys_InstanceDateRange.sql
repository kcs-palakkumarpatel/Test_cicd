CREATE FUNCTION [data].[AmazonRdsSqlServer_SqlProcess_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_SqlProcess_LoginTime AS BIGINT
    , @AmazonRdsSqlServer_SqlProcess_SessionId AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_SqlProcess_LoginTime], [AmazonRdsSqlServer_SqlProcess_SessionId]) AS
(
    SELECT [data].[AmazonRdsSqlServer_SqlProcess_Keys].[Id]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] AS [AmazonRdsSqlServer_SqlProcess_LoginTime]
    , [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] AS [AmazonRdsSqlServer_SqlProcess_SessionId]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_Keys] ON [data].[AmazonRdsSqlServer_SqlProcess_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_LoginTime] = @AmazonRdsSqlServer_SqlProcess_LoginTime
     AND [data].[AmazonRdsSqlServer_SqlProcess_Keys].[_SessionId] = @AmazonRdsSqlServer_SqlProcess_SessionId
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_SqlProcess_LoginTime]) AS [AmazonRdsSqlServer_SqlProcess_LoginTime_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_SqlProcess_SessionId]
FROM
 [SightedInstances]