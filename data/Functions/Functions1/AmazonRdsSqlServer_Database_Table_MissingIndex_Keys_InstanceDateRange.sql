CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_Schema AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_Table_Name], [AmazonRdsSqlServer_Database_Table_Schema], [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Table_Name]
    , [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] AS [AmazonRdsSqlServer_Database_Table_Schema]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns]
    , [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] AS [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Name] = @AmazonRdsSqlServer_Database_Table_Name
     AND [data].[AmazonRdsSqlServer_Database_Table_Keys].[_Schema] = @AmazonRdsSqlServer_Database_Table_Schema
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_EqualityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_IncludedColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns
     AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[_InequalityColumns] = @AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_Schema]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns]
, [SightedInstances].[AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]
FROM
 [SightedInstances]