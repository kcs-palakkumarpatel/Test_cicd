CREATE FUNCTION [data].[AmazonRdsSqlServer_TempDB_Objects_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TempDB_Objects_TempTableName AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TempDB_Objects_TempTableName]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[_TempTableName] AS [AmazonRdsSqlServer_TempDB_Objects_TempTableName]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_TempDB_Objects_Keys] ON [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_TempDB_Objects_Keys].[_TempTableName] = @AmazonRdsSqlServer_TempDB_Objects_TempTableName
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_TempDB_Objects_TempTableName]
FROM
 [SightedInstances]