﻿CREATE VIEW [config].[AzureManagedInstance_AlertConfiguration_View] AS SELECT[config].[AzureManagedInstance_AlertConfiguration].[Id] AS [Id], [config].[AzureManagedInstance_AlertConfiguration].[_AlertType] AS [AzureManagedInstance_AlertType], [config].[AzureManagedInstance_AlertConfiguration].[_SubType] AS [AzureManagedInstance_SubType], [config].[AzureManagedInstance_AlertConfiguration].[_Configuration] AS [AzureManagedInstance_Configuration], [config].[AzureManagedInstance_AlertConfiguration].[_Enabled] AS [AzureManagedInstance_Enabled], [config].[AzureManagedInstance_AlertConfiguration].[_AlertNotification] AS [AzureManagedInstance_AlertNotification], [config].[AzureManagedInstance_AlertConfiguration].[_EmailAddress] AS [AzureManagedInstance_EmailAddress], [config].[AzureManagedInstance_AlertConfiguration].[_Version] AS [AzureManagedInstance_Version], [config].[AzureManagedInstance_AlertConfiguration].[_Comments] AS [AzureManagedInstance_Comments], [config].[AzureManagedInstance_AlertConfiguration].[_SlackEnabled] AS [AzureManagedInstance_SlackEnabled], [config].[AzureManagedInstance_AlertConfiguration].[_SnmpEnabled] AS [AzureManagedInstance_SnmpEnabled], [config].[AzureManagedInstance_AlertConfiguration].[_WebhookEnabled] AS [AzureManagedInstance_WebhookEnabled], [data].[AzureManagedInstance_Keys].[_Name] AS [AzureManagedInstance_Name] FROM [config].[AzureManagedInstance_AlertConfiguration] INNER JOIN [data].[AzureManagedInstance_Keys] ON [data].[AzureManagedInstance_Keys].[Id] = [config].[AzureManagedInstance_AlertConfiguration].[Id]
;