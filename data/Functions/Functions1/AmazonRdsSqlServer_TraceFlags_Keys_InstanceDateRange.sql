CREATE FUNCTION [data].[AmazonRdsSqlServer_TraceFlags_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_TraceFlags_TraceFlag AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_TraceFlags_TraceFlag]) AS
(
    SELECT [data].[AmazonRdsSqlServer_TraceFlags_Keys].[Id]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_TraceFlags_Keys].[_TraceFlag] AS [AmazonRdsSqlServer_TraceFlags_TraceFlag]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_TraceFlags_Keys] ON [data].[AmazonRdsSqlServer_TraceFlags_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_TraceFlags_Keys].[_TraceFlag] = @AmazonRdsSqlServer_TraceFlags_TraceFlag
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