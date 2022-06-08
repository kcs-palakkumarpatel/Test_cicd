﻿CREATE VIEW [data].[Cluster_SqlServer_Properties_Registry_StableSamples_View] AS SELECT[data].[Cluster_SqlServer_Properties_Registry_StableSamples].[Id] AS [Id], [data].[Cluster_SqlServer_Keys].[CollectionDate] AS [IdCollectionDate], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_AuditLevel] AS [Cluster_SqlServer_Properties_Registry_AuditLevel], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_CertificateThumbprint] AS [Cluster_SqlServer_Properties_Registry_CertificateThumbprint], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_CustomerExperienceAuditDirectory] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceAuditDirectory], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_CustomerExperienceErrorReportingEnabled] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceErrorReportingEnabled], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_CustomerExperienceFeedbackEnabled] AS [Cluster_SqlServer_Properties_Registry_CustomerExperienceFeedbackEnabled], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_ForceEncryption] AS [Cluster_SqlServer_Properties_Registry_ForceEncryption], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_HideInstance] AS [Cluster_SqlServer_Properties_Registry_HideInstance], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_InstallationDirectory] AS [Cluster_SqlServer_Properties_Registry_InstallationDirectory], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[_MaxNumberErrorLogFiles] AS [Cluster_SqlServer_Properties_Registry_MaxNumberErrorLogFiles], [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[CollectionDate] AS [CollectionDate], [utils].[TicksToDateTime]([data].[Cluster_SqlServer_Properties_Registry_StableSamples].[CollectionDate]) AS [CollectionDate_DateTime], [data].[Cluster_Keys].[_Name] AS [Cluster_Name], [data].[Cluster_SqlServer_Keys].[_Name] AS [Cluster_SqlServer_Name] FROM [data].[Cluster_SqlServer_Properties_Registry_StableSamples] INNER JOIN [data].[Cluster_SqlServer_Keys] ON [data].[Cluster_SqlServer_Keys].[Id] = [data].[Cluster_SqlServer_Properties_Registry_StableSamples].[Id]
 INNER JOIN [data].[Cluster_Keys] ON [data].[Cluster_Keys].[Id] = [data].[Cluster_SqlServer_Keys].[ParentId]
;