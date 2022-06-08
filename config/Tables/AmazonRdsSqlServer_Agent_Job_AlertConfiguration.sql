CREATE TABLE [config].[AmazonRdsSqlServer_Agent_Job_AlertConfiguration] (
    [Id]                 BIGINT         NOT NULL,
    [_AlertType]         BIGINT         NOT NULL,
    [_SubType]           BIGINT         CONSTRAINT [DF_AmazonRdsSqlServer_Agent_Job_AlertConfiguration__SubType] DEFAULT ((0)) NOT NULL,
    [_Configuration]     XML            NOT NULL,
    [_Enabled]           BIT            NOT NULL,
    [_AlertNotification] BIGINT         NOT NULL,
    [_EmailAddress]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Comments]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 CONSTRAINT [DF_AmazonRdsSqlServer_Agent_Job_AlertConfiguration__Comments] DEFAULT ('') NOT NULL,
    [_Version]           BIGINT         NOT NULL,
    [_SlackEnabled]      BIT            CONSTRAINT [DF_AmazonRdsSqlServer_Agent_Job_AlertConfiguration__SlackEnabled] DEFAULT ((1)) NOT NULL,
    [_SnmpEnabled]       BIT            CONSTRAINT [DF_AmazonRdsSqlServer_Agent_Job_AlertConfiguration__SnmpEnabled] DEFAULT ((1)) NOT NULL,
    [_WebhookEnabled]    BIT            CONSTRAINT [DF_AmazonRdsSqlServer_Agent_Job_AlertConfiguration__WebhookEnabled] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_AlertConfiguration_Id__AlertType__SubType] PRIMARY KEY CLUSTERED ([Id] ASC, [_AlertType] ASC, [_SubType] ASC),
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_AlertConfiguration_AmazonRdsSqlServer_Agent_Job_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Agent_Job_Keys] ([Id]) ON DELETE CASCADE
);

