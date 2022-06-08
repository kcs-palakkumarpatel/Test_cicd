CREATE FUNCTION [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples_Removable]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TopQueries_DatabaseName AS NVARCHAR(450)
    , @AzureManagedInstance_TopQueries_SqlHandle AS VARBINARY(900)
    , @AzureManagedInstance_TopQueries_StatementEnd AS BIGINT
    , @AzureManagedInstance_TopQueries_StatementStart AS BIGINT
    , @AzureManagedInstance_TopQueries_QueryWaitStats_WaitType AS NVARCHAR(450)
)
RETURNS TABLE
AS
RETURN

SELECT [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[Id], [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[CollectionDate]
FROM [data].[AzureManagedInstance_Keys]
INNER JOIN [data].[AzureManagedInstance_TopQueries_Keys] ON [data].[AzureManagedInstance_TopQueries_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] ON [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[ParentId] = [data].[AzureManagedInstance_TopQueries_Keys].[Id]
INNER JOIN [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples] ON [data].[AzureManagedInstance_TopQueries_QueryWaitStats_StableSamples].[Id] = [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[Id]
 WHERE  (@AzureManagedInstance_Name IS NULL OR [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name)
 AND  (@AzureManagedInstance_TopQueries_DatabaseName IS NULL OR [data].[AzureManagedInstance_TopQueries_Keys].[_DatabaseName] = @AzureManagedInstance_TopQueries_DatabaseName)
 AND  (@AzureManagedInstance_TopQueries_SqlHandle IS NULL OR [data].[AzureManagedInstance_TopQueries_Keys].[_SqlHandle] = @AzureManagedInstance_TopQueries_SqlHandle)
 AND  (@AzureManagedInstance_TopQueries_StatementEnd IS NULL OR [data].[AzureManagedInstance_TopQueries_Keys].[_StatementEnd] = @AzureManagedInstance_TopQueries_StatementEnd)
 AND  (@AzureManagedInstance_TopQueries_StatementStart IS NULL OR [data].[AzureManagedInstance_TopQueries_Keys].[_StatementStart] = @AzureManagedInstance_TopQueries_StatementStart)
 AND  (@AzureManagedInstance_TopQueries_QueryWaitStats_WaitType IS NULL OR [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys].[_WaitType] = @AzureManagedInstance_TopQueries_QueryWaitStats_WaitType)