CREATE FUNCTION [data].[AmazonRdsSqlServer_Error_Keys_TopEvents]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @EventCount AS BIGINT
)
RETURNS TABLE
AS
RETURN
WITH [TopInstances]([Id], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Error_LogDate], [AmazonRdsSqlServer_Error_SequenceNumber]) AS
(
    SELECT [TopEvents].[Id]
    , [TopEvents].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [TopEvents].[_LogDate] AS [AmazonRdsSqlServer_Error_LogDate]
    , [TopEvents].[_SequenceNumber] AS [AmazonRdsSqlServer_Error_SequenceNumber]
    FROM [data].[AmazonRdsSqlServer_Keys]
    CROSS APPLY
        (
            SELECT TOP (@EventCount)
            [data].[AmazonRdsSqlServer_Error_Keys].[Id]
            , [data].[AmazonRdsSqlServer_Error_Keys].[CollectionDate]
            , [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate]
            , [data].[AmazonRdsSqlServer_Error_Keys].[_SequenceNumber]
            FROM [data].[AmazonRdsSqlServer_Error_Keys]
             WHERE [data].[AmazonRdsSqlServer_Error_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
             AND [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] >= @MinDate
             AND [data].[AmazonRdsSqlServer_Error_Keys].[_LogDate] <= @MaxDate
            ORDER BY [_LogDate] DESC
        )
        [TopEvents]
)
SELECT
[TopInstances].[Id]
, [TopInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([TopInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [TopInstances].[AmazonRdsSqlServer_Name]
, [TopInstances].[AmazonRdsSqlServer_Error_LogDate]
, [utils].[TicksToDateTime]([TopInstances].[AmazonRdsSqlServer_Error_LogDate]) AS [AmazonRdsSqlServer_Error_LogDate_DateTime]
, [TopInstances].[AmazonRdsSqlServer_Error_SequenceNumber]
FROM [TopInstances]