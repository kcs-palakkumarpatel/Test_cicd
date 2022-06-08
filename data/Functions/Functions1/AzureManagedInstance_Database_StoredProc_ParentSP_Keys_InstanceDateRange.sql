CREATE FUNCTION [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_StoredProc_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent AS NVARCHAR(450)
    , @AzureManagedInstance_Database_StoredProc_ParentSP_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_StoredProc_Name], [AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent], [AzureManagedInstance_Database_StoredProc_ParentSP_Name]) AS
(
    SELECT [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[Id]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_StoredProc_Keys].[_Name] AS [AzureManagedInstance_Database_StoredProc_Name]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_DatabaseNameParent] AS [AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent]
    , [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_Name] AS [AzureManagedInstance_Database_StoredProc_ParentSP_Name]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_StoredProc_Keys] ON [data].[AzureManagedInstance_Database_StoredProc_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys] ON [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[ParentId] = [data].[AzureManagedInstance_Database_StoredProc_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name
     AND [data].[AzureManagedInstance_Database_StoredProc_Keys].[_Name] = @AzureManagedInstance_Database_StoredProc_Name
     AND [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_DatabaseNameParent] = @AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent
     AND [data].[AzureManagedInstance_Database_StoredProc_ParentSP_Keys].[_Name] = @AzureManagedInstance_Database_StoredProc_ParentSP_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_Name]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_ParentSP_DatabaseNameParent]
, [SightedInstances].[AzureManagedInstance_Database_StoredProc_ParentSP_Name]
FROM
 [SightedInstances]