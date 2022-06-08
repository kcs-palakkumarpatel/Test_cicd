CREATE TABLE [versioning].[DataVersionHistory] (
    [Id]              INT            IDENTITY (1, 1) NOT NULL,
    [Date]            DATETIME       NOT NULL,
    [CodeVersion]     NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [SchemaVersion]   NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [DataUpgradeStep] BIGINT         NOT NULL,
    CONSTRAINT [DataVersionHistory_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

