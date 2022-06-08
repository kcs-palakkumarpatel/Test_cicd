CREATE TABLE [data].[AzureSqlServer_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureSqlServer_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Keys__Name] UNIQUE NONCLUSTERED ([_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_Keys_CollectionDate]
    ON [data].[AzureSqlServer_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

