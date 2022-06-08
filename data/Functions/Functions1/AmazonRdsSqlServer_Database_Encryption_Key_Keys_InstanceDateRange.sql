CREATE FUNCTION [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Encryption_Key_Id AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Database_Encryption_Key_Type AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Database_Name], [AmazonRdsSqlServer_Database_Encryption_Key_Id], [AmazonRdsSqlServer_Database_Encryption_Key_Type]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Database_Keys].[_Name] AS [AmazonRdsSqlServer_Database_Name]
    , [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Id] AS [AmazonRdsSqlServer_Database_Encryption_Key_Id]
    , [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Type] AS [AmazonRdsSqlServer_Database_Encryption_Key_Type]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Keys] ON [data].[AmazonRdsSqlServer_Database_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
    INNER JOIN [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys] ON [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Database_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Database_Keys].[_Name] = @AmazonRdsSqlServer_Database_Name
     AND [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Id] = @AmazonRdsSqlServer_Database_Encryption_Key_Id
     AND [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys].[_Type] = @AmazonRdsSqlServer_Database_Encryption_Key_Type
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Name]
, [SightedInstances].[AmazonRdsSqlServer_Database_Encryption_Key_Id]
, [SightedInstances].[AmazonRdsSqlServer_Database_Encryption_Key_Type]
FROM
 [SightedInstances]