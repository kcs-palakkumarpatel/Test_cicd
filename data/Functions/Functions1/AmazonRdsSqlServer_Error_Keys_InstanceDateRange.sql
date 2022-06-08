CREATE FUNCTION [data].[AmazonRdsSqlServer_Error_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Error_LogDate AS BIGINT
    , @AmazonRdsSqlServer_Error_SequenceNumber AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Error_LogDate], [AmazonRdsSqlServer_Error_SequenceNumber]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Error_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Error_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Error_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] AS [AmazonRdsSqlServer_Error_LogDate]
    , [data].[AmazonRdsSqlServer_Error_Keys].[_SequenceNumber] AS [AmazonRdsSqlServer_Error_SequenceNumber]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Error_Keys] ON [data].[AmazonRdsSqlServer_Error_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] = @AmazonRdsSqlServer_Error_LogDate
     AND [data].[AmazonRdsSqlServer_Error_Keys].[_SequenceNumber] = @AmazonRdsSqlServer_Error_SequenceNumber
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Error_LogDate]
, [utils].[TicksToDateTime]([SightedInstances].[AmazonRdsSqlServer_Error_LogDate]) AS [AmazonRdsSqlServer_Error_LogDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Error_SequenceNumber]
FROM
 [SightedInstances]