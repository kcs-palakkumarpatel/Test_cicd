CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_StableSamples_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_Name AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_Agent_Job_StableSamples].[Id], [data].[AmazonRdsSqlServer_Agent_Job_StableSamples].[CollectionDate]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_StableSamples] ON [data].[AmazonRdsSqlServer_Agent_Job_StableSamples].[Id] = [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_Agent_Job_Name IS NULL OR [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] = @AmazonRdsSqlServer_Agent_Job_Name)