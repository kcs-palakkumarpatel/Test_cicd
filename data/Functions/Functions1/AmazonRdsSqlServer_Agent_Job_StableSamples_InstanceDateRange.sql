CREATE FUNCTION [data].[AmazonRdsSqlServer_Agent_Job_StableSamples_InstanceDateRange]
(
    @AmazonRdsSqlServer_Name AS NVARCHAR(450)
    , @AmazonRdsSqlServer_Agent_Job_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [AmazonRdsSqlServer_Name], [AmazonRdsSqlServer_Agent_Job_Name]) AS
(
    SELECT [data].[AmazonRdsSqlServer_Agent_Job_Keys].[Id]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[AmazonRdsSqlServer_Keys].[_Name] AS [AmazonRdsSqlServer_Name]
    , [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] AS [AmazonRdsSqlServer_Agent_Job_Name]
    FROM [data].[AmazonRdsSqlServer_Keys]
    INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Keys] ON [data].[AmazonRdsSqlServer_Agent_Job_Keys].[ParentId] = [data].[AmazonRdsSqlServer_Keys].[Id]
     WHERE [data].[AmazonRdsSqlServer_Keys].[_Name] = @AmazonRdsSqlServer_Name
     AND [data].[AmazonRdsSqlServer_Agent_Job_Keys].[_Name] = @AmazonRdsSqlServer_Agent_Job_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[AmazonRdsSqlServer_Name]
, [SightedInstances].[AmazonRdsSqlServer_Agent_Job_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_CategoryName] AS [AmazonRdsSqlServer_Agent_Job_CategoryName]
, [Leaf].[_DatabaseNameOrNone] AS [AmazonRdsSqlServer_Agent_Job_DatabaseNameOrNone]
, [Leaf].[_DateModified] AS [AmazonRdsSqlServer_Agent_Job_DateModified]
, [utils].[TicksToDateTime]([Leaf].[_DateModified]) AS [AmazonRdsSqlServer_Agent_Job_DateModified_DateTime]
, [Leaf].[_Description] AS [AmazonRdsSqlServer_Agent_Job_Description]
, [Leaf].[_Enabled] AS [AmazonRdsSqlServer_Agent_Job_Enabled]
, [Leaf].[_Owner] AS [AmazonRdsSqlServer_Agent_Job_Owner]
, [Leaf].[_OwnerSid] AS [AmazonRdsSqlServer_Agent_Job_OwnerSid]
, [Leaf].[_VersionNumber] AS [AmazonRdsSqlServer_Agent_Job_VersionNumber]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[AmazonRdsSqlServer_Agent_Job_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[AmazonRdsSqlServer_Agent_Job_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate