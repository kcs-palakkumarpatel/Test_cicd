CREATE FUNCTION [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys_InstanceDateRange]
(
    @AzureSqlServer_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_Name AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent AS NVARCHAR(450)
    , @AzureSqlServer_Database_StoredProcedure_ParentSP_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureSqlServer_Name], [AzureSqlServer_Database_Name], [AzureSqlServer_Database_StoredProcedure_Name], [AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent], [AzureSqlServer_Database_StoredProcedure_ParentSP_Name]) AS
(
    SELECT [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[Id]
    , [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId]
    , [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureSqlServer_Keys].[_Name] AS [AzureSqlServer_Name]
    , [data].[AzureSqlServer_Database_Keys].[_Name] AS [AzureSqlServer_Database_Name]
    , [data].[AzureSqlServer_Database_StoredProcedure_Keys].[_Name] AS [AzureSqlServer_Database_StoredProcedure_Name]
    , [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] AS [AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent]
    , [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] AS [AzureSqlServer_Database_StoredProcedure_ParentSP_Name]
    FROM [data].[AzureSqlServer_Keys]
    INNER JOIN [data].[AzureSqlServer_Database_Keys] ON [data].[AzureSqlServer_Database_Keys].[ParentId] = [data].[AzureSqlServer_Keys].[Id]
    INNER JOIN [data].[AzureSqlServer_Database_StoredProcedure_Keys] ON [data].[AzureSqlServer_Database_StoredProcedure_Keys].[ParentId] = [data].[AzureSqlServer_Database_Keys].[Id]
    INNER JOIN [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys] ON [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[ParentId] = [data].[AzureSqlServer_Database_StoredProcedure_Keys].[Id]
     WHERE [data].[AzureSqlServer_Keys].[_Name] = @AzureSqlServer_Name
     AND [data].[AzureSqlServer_Database_Keys].[_Name] = @AzureSqlServer_Database_Name
     AND [data].[AzureSqlServer_Database_StoredProcedure_Keys].[_Name] = @AzureSqlServer_Database_StoredProcedure_Name
     AND [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_DatabaseNameParent] = @AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent
     AND [data].[AzureSqlServer_Database_StoredProcedure_ParentSP_Keys].[_Name] = @AzureSqlServer_Database_StoredProcedure_ParentSP_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureSqlServer_Name]
, [SightedInstances].[AzureSqlServer_Database_Name]
, [SightedInstances].[AzureSqlServer_Database_StoredProcedure_Name]
, [SightedInstances].[AzureSqlServer_Database_StoredProcedure_ParentSP_DatabaseNameParent]
, [SightedInstances].[AzureSqlServer_Database_StoredProcedure_ParentSP_Name]
FROM
 [SightedInstances]