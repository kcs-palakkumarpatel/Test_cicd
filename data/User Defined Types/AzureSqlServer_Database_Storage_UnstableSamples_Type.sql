CREATE TYPE [data].[AzureSqlServer_Database_Storage_UnstableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_DatabaseUsedSizeInBytes] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

