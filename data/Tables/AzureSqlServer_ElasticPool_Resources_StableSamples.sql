CREATE TABLE [data].[AzureSqlServer_ElasticPool_Resources_StableSamples] (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_ElasticPoolDtuLimit]     BIGINT NULL,
    [_ElasticPoolStorageLimit] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_ElasticPool_Resources_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_ElasticPool_Resources_StableSamples_AzureSqlServer_ElasticPool_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_ElasticPool_Keys] ([Id]) ON DELETE CASCADE
);

