CREATE FUNCTION [data].[AmazonRdsSqlServer_ExtendedEvents_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ExtendedEvents_EventName AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ExtendedEvents_Sequence AS BIGINT
    , @AmazonRdsSqlServer_ExtendedEvents_TimeStamp AS BIGINT
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_ExtendedEvents_Keys] ON [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_ExtendedEvents_EventName IS NULL OR [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_EventName] = @AmazonRdsSqlServer_ExtendedEvents_EventName)
 AND  (@AmazonRdsSqlServer_ExtendedEvents_Sequence IS NULL OR [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_Sequence] = @AmazonRdsSqlServer_ExtendedEvents_Sequence)
 AND  (@AmazonRdsSqlServer_ExtendedEvents_TimeStamp IS NULL OR [data].[AmazonRdsSqlServer_ExtendedEvents_Keys].[_TimeStamp] = @AmazonRdsSqlServer_ExtendedEvents_TimeStamp)