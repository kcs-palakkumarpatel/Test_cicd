CREATE TABLE [settings].[WebhookSettings] (
    [Id]              INT            NOT NULL,
    [Enable]          BIT            NOT NULL,
    [Url]             NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Template]        NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [Headers]         NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NULL,
    [IgnoreSslErrors] BIT            CONSTRAINT [IgnoreSslErrors_WebhookSettingsDefault] DEFAULT ((0)) NULL,
    CONSTRAINT [WebhookSettings_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

