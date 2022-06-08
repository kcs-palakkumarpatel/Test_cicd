CREATE FUNCTION [data].[AzureManagedInstance_Database_Table_MissingIndex_Plans_Instances_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Table_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Table_Schema AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Table_MissingIndex_EqualityColumns AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Table_MissingIndex_IncludedColumns AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Table_MissingIndex_InequalityColumns AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_Table_Name], [AzureManagedInstance_Database_Table_Schema], [AzureManagedInstance_Database_Table_MissingIndex_EqualityColumns], [AzureManagedInstance_Database_Table_MissingIndex_IncludedColumns], [AzureManagedInstance_Database_Table_MissingIndex_InequalityColumns]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Name] AS [AzureManagedInstance_Database_Table_Name]
    , [data].[AzureManagedInstance_Database_Table_Keys].[_Schema] AS [AzureManagedInstance_Database_Table_Schema]
    , [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_EqualityColumns] AS [AzureManagedInstance_Database_Table_MissingIndex_EqualityColumns]
    , [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_IncludedColumns] AS [AzureManagedInstance_Database_Table_MissingIndex_IncludedColumns]
    , [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_InequalityColumns] AS [AzureManagedInstance_Database_Table_MissingIndex_InequalityColumns]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_Table_Keys] ON [data].[AzureManagedInstance_Database_Table_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys] ON [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Table_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name
     AND [data].[AzureManagedInstance_Database_Table_Keys].[_Name] = @AzureManagedInstance_Database_Table_Name
     AND [data].[AzureManagedInstance_Database_Table_Keys].[_Schema] = @AzureManagedInstance_Database_Table_Schema
     AND [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_EqualityColumns] = @AzureManagedInstance_Database_Table_MissingIndex_EqualityColumns
     AND [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_IncludedColumns] = @AzureManagedInstance_Database_Table_MissingIndex_IncludedColumns
     AND [data].[AzureManagedInstance_Database_Table_MissingIndex_Keys].[_InequalityColumns] = @AzureManagedInstance_Database_Table_MissingIndex_InequalityColumns
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_Table_Name]
, [SightedInstances].[AzureManagedInstance_Database_Table_Schema]
, [SightedInstances].[AzureManagedInstance_Database_Table_MissingIndex_EqualityColumns]
, [SightedInstances].[AzureManagedInstance_Database_Table_MissingIndex_IncludedColumns]
, [SightedInstances].[AzureManagedInstance_Database_Table_MissingIndex_InequalityColumns]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_PlanHandle] AS [AzureManagedInstance_Database_Table_MissingIndex_Plans_PlanHandle]
FROM
 [SightedInstances]
INNER JOIN
 [data].[AzureManagedInstance_Database_Table_MissingIndex_Plans_Instances] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]