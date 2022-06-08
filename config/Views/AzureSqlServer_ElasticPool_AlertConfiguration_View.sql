﻿CREATE VIEW [config].[AzureSqlServer_ElasticPool_AlertConfiguration_View] AS SELECT[config].[AzureSqlServer_ElasticPool_AlertConfiguration].[Id] AS [Id], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_AlertType] AS [AzureSqlServer_ElasticPool_AlertType], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_SubType] AS [AzureSqlServer_ElasticPool_SubType], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_Configuration] AS [AzureSqlServer_ElasticPool_Configuration], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_Enabled] AS [AzureSqlServer_ElasticPool_Enabled], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_AlertNotification] AS [AzureSqlServer_ElasticPool_AlertNotification], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_EmailAddress] AS [AzureSqlServer_ElasticPool_EmailAddress], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_Version] AS [AzureSqlServer_ElasticPool_Version], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_Comments] AS [AzureSqlServer_ElasticPool_Comments], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_SlackEnabled] AS [AzureSqlServer_ElasticPool_SlackEnabled], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_SnmpEnabled] AS [AzureSqlServer_ElasticPool_SnmpEnabled], [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[_WebhookEnabled] AS [AzureSqlServer_ElasticPool_WebhookEnabled], [data].[AzureSqlServer_Keys].[_Name] AS [AzureSqlServer_Name], [data].[AzureSqlServer_ElasticPool_Keys].[_Name] AS [AzureSqlServer_ElasticPool_Name] FROM [config].[AzureSqlServer_ElasticPool_AlertConfiguration] INNER JOIN [data].[AzureSqlServer_ElasticPool_Keys] ON [data].[AzureSqlServer_ElasticPool_Keys].[Id] = [config].[AzureSqlServer_ElasticPool_AlertConfiguration].[Id]
 INNER JOIN [data].[AzureSqlServer_Keys] ON [data].[AzureSqlServer_Keys].[Id] = [data].[AzureSqlServer_ElasticPool_Keys].[ParentId]
;