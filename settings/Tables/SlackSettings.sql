CREATE TABLE [settings].[SlackSettings] (
    [Id]           INT            NOT NULL,
    [Enable]       BIT            NOT NULL,
    [WebhookUrl]   NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Channel]      NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [UserName]     NVARCHAR (255) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [AlertOnEnded] BIT            NOT NULL,
    CONSTRAINT [SlackSettings_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

