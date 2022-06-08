CREATE TABLE [alert].[AlertSuppressionLevel] (
    [Id]   INT            NOT NULL,
    [Name] NVARCHAR (128) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [PK_AlertSuppressionLevel__Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_AlertSuppressionLevel__Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

