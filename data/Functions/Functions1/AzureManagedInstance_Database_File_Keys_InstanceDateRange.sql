﻿CREATE FUNCTION [data].[AzureManagedInstance_Database_File_Keys_InstanceDateRange]
(
    @AzureManagedInstance_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_File_Name AS NVARCHAR(450)
    , @AzureManagedInstance_Database_File_Type AS BIGINT
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_File_Name], [AzureManagedInstance_Database_File_Type]) AS
(
    SELECT [data].[AzureManagedInstance_Database_File_Keys].[Id]
    , [data].[AzureManagedInstance_Database_File_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_File_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_File_Keys].[_Name] AS [AzureManagedInstance_Database_File_Name]
    , [data].[AzureManagedInstance_Database_File_Keys].[_Type] AS [AzureManagedInstance_Database_File_Type]
    FROM [data].[AzureManagedInstance_Keys]
    INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[ParentId] = [data].[AzureManagedInstance_Keys].[Id]
    INNER JOIN [data].[AzureManagedInstance_Database_File_Keys] ON [data].[AzureManagedInstance_Database_File_Keys].[ParentId] = [data].[AzureManagedInstance_Database_Keys].[Id]
     WHERE [data].[AzureManagedInstance_Keys].[_Name] = @AzureManagedInstance_Name
     AND [data].[AzureManagedInstance_Database_Keys].[_Name] = @AzureManagedInstance_Database_Name
     AND [data].[AzureManagedInstance_Database_File_Keys].[_Name] = @AzureManagedInstance_Database_File_Name
     AND [data].[AzureManagedInstance_Database_File_Keys].[_Type] = @AzureManagedInstance_Database_File_Type
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_File_Name]
, [SightedInstances].[AzureManagedInstance_Database_File_Type]
FROM
 [SightedInstances]