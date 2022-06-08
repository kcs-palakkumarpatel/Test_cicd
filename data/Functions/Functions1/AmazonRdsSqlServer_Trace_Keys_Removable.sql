CREATE FUNCTION [data].[AmazonRdsSqlServer_Trace_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Trace_SequenceNumber AS BIGINT
    , @AmazonRdsSqlServer_Trace_StartTime AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Trace_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Trace_Keys] ON [data].[AmazonRdsSqlServer_Trace_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Trace_SequenceNumber IS NULL OR [data].[AmazonRdsSqlServer_Trace_Keys].[_SequenceNumber] = @AmazonRdsSqlServer_Trace_SequenceNumber)
 AND  (@AmazonRdsSqlServer_Trace_StartTime IS NULL OR [data].[AmazonRdsSqlServer_Trace_Keys].[_StartTime] = @AmazonRdsSqlServer_Trace_StartTime)