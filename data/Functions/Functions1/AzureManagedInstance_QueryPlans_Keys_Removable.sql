CREATE FUNCTION [data].[AzureManagedInstance_QueryPlans_Keys_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_QueryPlans_CreateDate AS BIGINT
    , @AzureManagedInstance_QueryPlans_PlanHandle AS VARBINARY(900)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_QueryPlans_Keys].[Id]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_QueryPlans_Keys] ON [data].[AzureManagedInstance_QueryPlans_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_QueryPlans_CreateDate IS NULL OR [data].[AzureManagedInstance_QueryPlans_Keys].[_CreateDate] = @AzureManagedInstance_QueryPlans_CreateDate)
 AND  (@AzureManagedInstance_QueryPlans_PlanHandle IS NULL OR [data].[AzureManagedInstance_QueryPlans_Keys].[_PlanHandle] = @AzureManagedInstance_QueryPlans_PlanHandle)