CREATE FUNCTION [data].[AmazonRdsSqlServer_Process_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Process_Pid AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Process_Name], [AmazonRdsSqlServer_Process_Pid]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Process_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Process_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Process_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Name] AS [AmazonRdsSqlServer_Process_Name]
    , [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] AS [AmazonRdsSqlServer_Process_Pid]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Process_Keys] ON [data].[AmazonRdsSqlServer_Process_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Process_Keys].[_Name] = @AmazonRdsSqlServer_Process_Name
     AND [data].[AmazonRdsSqlServer_Process_Keys].[_Pid] = @AmazonRdsSqlServer_Process_Pid
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Name]
, [SightedInstances].[AmazonRdsSqlServer_Process_Pid]
FROM
 [SightedInstances]