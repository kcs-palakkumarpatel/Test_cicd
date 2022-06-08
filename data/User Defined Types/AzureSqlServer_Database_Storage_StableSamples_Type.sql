CREATE TYPE [data].[AzureSqlServer_Database_Storage_StableSamples_Type] AS TABLE (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_DatabaseMaxSizeInBytes] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

