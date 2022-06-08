CREATE TABLE [data].[Group_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Group_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [Group_Keys__Name] UNIQUE NONCLUSTERED ([_Name] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Group_Keys_CollectionDate]
    ON [data].[Group_Keys]([CollectionDate] ASC);

