﻿CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys_DateRange]
(
    @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedIds]([Id]) AS
(
    SELECT DISTINCT [Id]
    FROM [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Sightings]
    WHERE [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Sightings].[SightingDate] >= @MinDate AND [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_Table_Name], [AmazonRdsSqlServer_Database_Table_Schema], [AmazonRdsSqlServer_Database_Table_MissingIndex_EqualityColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_IncludedColumns], [AmazonRdsSqlServer_Database_Table_MissingIndex_InequalityColumns]) AS
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
    FROM [SightedIds]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Table_Keys] ON [data].[AmazonRdsSqlServer_Database_Table_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Table_Keys].[ParentId]
     INNER JOIN [data].[AmazonRdsSqlServer_Keys] ON [data].[AmazonRdsSqlServer_Keys].[Id] = [data].[AmazonRdsSqlServer_Database_Keys].[ParentId]
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