CREATE TABLE [settings].[SnmpSettings] (
    [Id]           INT NOT NULL,
    [Enable]       BIT NOT NULL,
    [AlertOnEnded] BIT NOT NULL,
    CONSTRAINT [SnmpSettings_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

