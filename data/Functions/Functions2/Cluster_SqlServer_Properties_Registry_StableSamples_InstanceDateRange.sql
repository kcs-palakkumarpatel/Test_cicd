CREATE FUNCTION [data].[Cluster_SqlServer_Properties_Registry_StableSamples_InstanceDateRange]
(
    @Cluster_Name AS NVARCHAR(450)
    , @Cluster_SqlServer_Name AS NVARCHAR(450)
    , @MinDate AS BIGINT
    , @MaxDate AS BIGINT
    , @MaxSamples AS INT
)
RETURNS TABLE
AS
RETURN
WITH [SightedInstances]([Id], [ParentId], [IdCollectionDate], [Cluster_Name], [Cluster_SqlServer_Name]) AS
(
    SELECT [data].[Cluster_SqlServer_Keys].[Id]
    , [data].[Cluster_SqlServer_Keys].[ParentId]
    , [data].[Cluster_SqlServer_Keys].[CollectionDate] AS [IdCollectionDate]
    , [data].[Cluster_Keys].[_Name] AS [Cluster_Name]
    , [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name]
    FROM [data].[Cluster_Keys]
    INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[ParentId] = [data].[Cluster_Keys].[Id]
     WHERE [data].[Cluster_Keys].[_Name] = @Cluster_Name
     AND [data].[Cluster_SqlServer_Keys].[_Name] = @Cluster_SqlServer_Name
)
SELECT
[SightedInstances].[Id]
, [SightedInstances].[ParentId]
, [SightedInstances].[IdCollectionDate]
, [utils].[TicksToDateTime]([SightedInstances].[IdCollectionDate]) AS [IdCollectionDate_DateTime]
, [SightedInstances].[Cluster_Name]
, [SightedInstances].[Cluster_SqlServer_Name]
, [Leaf].[CollectionDate]
, [utils].[TicksToDateTime]([Leaf].[CollectionDate]) AS [CollectionDate_DateTime]
, [Leaf].[_AuditLevel] AS [Cluster_SqlServer_Properties_Registry_AuditLevel]
, [Leaf].[_CertificateThumbprint] AS [Cluster_SqlServer_Properties_Registry_CertificateThumbprint]
, [Leaf].[_CustomerExperienceAuditDirectory] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceAuditDirectory]
, [Leaf].[_CustomerExperienceErrorReportingEnabled] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceErrorReportingEnabled]
, [Leaf].[_CustomerExperienceFeedbackEnabled] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceFeedbackEnabled]
, [Leaf].[_ForceEncryption] AS [Cluster_SqlServer_Properties_Registry_ForceEncryption]
, [Leaf].[_HideInstance] AS [Cluster_SqlServer_Properties_Registry_HideInstance]
, [Leaf].[_InstallationDirectory] AS [Cluster_SqlServer_Properties_Registry_InstallationDirectory]
, [Leaf].[_MaxNumberErrorLogFiles] AS [Cluster_SqlServer_Properties_Registry_MaxNumberErrorLogFiles]
FROM
 [SightedInstances]
LEFT OUTER JOIN
(
    SELECT [Id], MAX([CollectionDate]) as [GreatestMinDate]
    FROM [data].[Cluster_SqlServer_Properties_Registry_StableSamples]
    WHERE [CollectionDate] <= @MinDate
    GROUP BY [Id]
)
[GreatestMinDates]
 ON [SightedInstances].[Id] = [GreatestMinDates].[Id]
INNER JOIN
 [data].[Cluster_SqlServer_Properties_Registry_StableSamples] [Leaf]
 ON [SightedInstances].[Id] = [Leaf].[Id]
WHERE [Leaf].[CollectionDate] >= COALESCE([GreatestMinDates].[GreatestMinDate], @MinDate)
AND [Leaf].[CollectionDate] <= @MaxDate