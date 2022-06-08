CREATE FUNCTION [data].[AzureManagedInstance_TempDB_Files_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_TempDB_Files_FileName AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_TempDB_Files_FileName]) AS
(
    SELECT [data].[AzureManagedInstance_TempDB_Files_Keys].[Id]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] AS [AzureManagedInstance_TempDB_Files_FileName]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_TempDB_Files_Keys] ON [data].[AzureManagedInstance_TempDB_Files_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_TempDB_Files_Keys].[_FileName] = @AzureManagedInstance_TempDB_Files_FileName
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_TempDB_Files_FileName]
FROM
 [SightedInstances]