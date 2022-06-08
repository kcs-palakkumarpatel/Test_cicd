CREATE TABLE [alert].[AlertTypeGroupToSuppress] (
    [Id]   INT            NOT NULL,
    [Name] NVARCHAR (128) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [PK_AlertTypeGroupToSuppress__Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [UQ_AlertTypeGroupToSuppress__Name] UNIQUE NONCLUSTERED ([Name] ASC)
);

