CREATE FUNCTION [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples].[Id], [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples] ON [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples].[Id] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)