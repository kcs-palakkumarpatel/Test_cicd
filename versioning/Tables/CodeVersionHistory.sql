CREATE TABLE [versioning].[CodeVersionHistory] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Date]        DATETIME       NOT NULL,
    [CodeVersion] NVARCHAR (MAX) COLLATE Latin1_General_CS_AS_KS_WS NOT NULL,
    CONSTRAINT [CodeVersionHistory_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

