CREATE TABLE [data].[AzureSqlServer_Database_SqlText_Keys] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_SqlHandle]     VARBINARY (900) NOT NULL,
    CONSTRAINT [AzureSqlServer_Database_SqlText_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_SqlText_Keys_AzureSqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlServer_Database_SqlText_Keys_ParentId__SqlHandle] UNIQUE NONCLUSTERED ([ParentId] ASC, [_SqlHandle] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_Database_SqlText_Keys_CollectionDate]
    ON [data].[AzureSqlServer_Database_SqlText_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

