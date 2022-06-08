CREATE TABLE [config].[AzureManagedInstance_Database_AlertConfiguration] (
    [Id]                 BIGINT         NOT NULL,
    [_AlertType]         BIGINT         NOT NULL,
    [_SubType]           BIGINT         CONSTRAINT [DF_AzureManagedInstance_Database_AlertConfiguration__SubType] DEFAULT ((0)) NOT NULL,
    [_Configuration]     XML            NOT NULL,
    [_Enabled]           BIT            NOT NULL,
    [_AlertNotification] BIGINT         NOT NULL,
    [_EmailAddress]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Comments]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 CONSTRAINT [DF_AzureManagedInstance_Database_AlertConfiguration__Comments] DEFAULT ('') NOT NULL,
    [_Version]           BIGINT         NOT NULL,
    [_SlackEnabled]      BIT            CONSTRAINT [DF_AzureManagedInstance_Database_AlertConfiguration__SlackEnabled] DEFAULT ((1)) NOT NULL,
    [_SnmpEnabled]       BIT            CONSTRAINT [DF_AzureManagedInstance_Database_AlertConfiguration__SnmpEnabled] DEFAULT ((1)) NOT NULL,
    [_WebhookEnabled]    BIT            CONSTRAINT [DF_AzureManagedInstance_Database_AlertConfiguration__WebhookEnabled] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [AzureManagedInstance_Database_AlertConfiguration_Id__AlertType__SubType] PRIMARY KEY CLUSTERED ([Id] ASC, [_AlertType] ASC, [_SubType] ASC),
    CONSTRAINT [AzureManagedInstance_Database_AlertConfiguration_AzureManagedInstance_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE
);

