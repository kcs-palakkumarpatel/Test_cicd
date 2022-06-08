CREATE FUNCTION [data].[AmazonRdsSqlServer_ServerWaits_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_ServerWaits_WaitType AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_ServerWaits_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_ServerWaits_Keys] ON [data].[AmazonRdsSqlServer_ServerWaits_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_ServerWaits_WaitType IS NULL OR [data].[AmazonRdsSqlServer_ServerWaits_Keys].[_WaitType] = @AmazonRdsSqlServer_ServerWaits_WaitType)