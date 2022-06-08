CREATE FUNCTION [data].[AmazonRdsSqlServer_QueryPlans_Keys_Removable]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_QueryPlans_CreateDate AS BIGINT
    , @AmazonRdsSqlServer_QueryPlans_PlanHandle AS VARBINARY(900)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AmazonRdsSqlServer_QueryPlans_Keys].[Id]
FROM [data].[AmazonRdsSqlServer_Keys]
INNER JOIN [data].[AmazonRdsSqlServer_QueryPlans_Keys] ON [data].[AmazonRdsSqlServer_QueryPlans_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
 WHERE  (@AmazonRdsSqlServer_Name IS NULL OR [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name)
 AND  (@AmazonRdsSqlServer_QueryPlans_CreateDate IS NULL OR [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_CreateDate] = @AmazonRdsSqlServer_QueryPlans_CreateDate)
 AND  (@AmazonRdsSqlServer_QueryPlans_PlanHandle IS NULL OR [data].[AmazonRdsSqlServer_QueryPlans_Keys].[_PlanHandle] = @AmazonRdsSqlServer_QueryPlans_PlanHandle)