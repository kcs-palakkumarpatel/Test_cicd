CREATE TYPE [data].[AzureSqlServer_ElasticPool_Resources_StableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_ElasticPoolDtuLimit]     BIGINT NULL,
    [_ElasticPoolStorageLimit] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

