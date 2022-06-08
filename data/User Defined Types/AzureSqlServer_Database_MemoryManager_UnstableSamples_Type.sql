CREATE TYPE [data].[AzureSqlServer_Database_MemoryManager_UnstableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_FreeMemoryBytes]         BIGINT NULL,
    [_TargetServerMemoryBytes] BIGINT NULL,
    [_TotalServerMemoryBytes]  BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

