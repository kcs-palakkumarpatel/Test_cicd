CREATE FUNCTION [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples_DateRange]
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
    FROM [data].[AzureManagedInstance_Database_Encryption_Key_Sightings]
    WHERE [data].[AzureManagedInstance_Database_Encryption_Key_Sightings].[SightingDate] >= @MinDate AND [data].[AzureManagedInstance_Database_Encryption_Key_Sightings].[SightingDate] <= @MaxDate
)
, [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AzureManagedInstance_Name], [AzureManagedInstance_Database_Name], [AzureManagedInstance_Database_Encryption_Key_Id], [AzureManagedInstance_Database_Encryption_Key_Type]) AS
(
    SELECT [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[Id]
    , [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[ParentId]
    , [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name]
    , [data].[AzureManagedInstance_Database_Keys].[_Name] AS [AzureManagedInstance_Database_Name]
    , [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[_Id] AS [AzureManagedInstance_Database_Encryption_Key_Id]
    , [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[_Type] AS [AzureManagedInstance_Database_Encryption_Key_Type]
    FROM [SightedIds]
     INNER JOIN [data].[AzureManagedInstance_Database_Encryption_Key_Keys] ON [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[Id] = [SightedIds].[Id]
     INNER JOIN [data].[AzureManagedInstance_Database_Keys] ON [data].[AzureManagedInstance_Database_Keys].[Id] = [data].[AzureManagedInstance_Database_Encryption_Key_Keys].[ParentId]
     INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [data].[AzureManagedInstance_Database_Keys].[ParentId]
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AzureManagedInstance_Name]
, [SightedInstances].[AzureManagedInstance_Database_Name]
, [SightedInstances].[AzureManagedInstance_Database_Encryption_Key_Id]
, [SightedInstances].[AzureManagedInstance_Database_Encryption_Key_Type]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_Algorithm] AS [AzureManagedInstance_Database_Encryption_Key_Algorithm]
, [Leaf].[_EncryptionType] AS [AzureManagedInstance_Database_Encryption_Key_EncryptionType]
, [Leaf].[_Name] AS [AzureManagedInstance_Database_Encryption_Key_Name]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AzureManagedInstance_Database_Encryption_Key_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate