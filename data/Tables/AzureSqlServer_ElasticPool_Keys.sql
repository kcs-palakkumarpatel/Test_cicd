CREATE TABLE [data].[AzureSqlServer_ElasticPool_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AzureSqlServer_ElasticPool_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_ElasticPool_Keys_AzureSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureSqlServer_ElasticPool_Keys_ParentId__Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_ElasticPool_Keys_CollectionDate]
    ON [data].[AzureSqlServer_ElasticPool_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

