CREATE TABLE [settings].[ReportDefinitions] (
    [Id]              INT             IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (50)   COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    [Definition]      XML             NOT NULL,
    [LastGenerated]   DATETIME        NULL,
    [GeneratedReport] VARBINARY (MAX) NULL,
    [Created]         DATETIME        NULL,
    [Modified]        DATETIME        NULL,
    CONSTRAINT [PK_ReportDefinition] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ReportDefinitions_Name]
    ON [settings].[ReportDefinitions]([Name] ASC);

