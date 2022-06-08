CREATE TABLE [data].[AzureSqlServer_Database_MemoryManager_UnstableSamples] (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_FreeMemoryBytes]         BIGINT NULL,
    [_TargetServerMemoryBytes] BIGINT NULL,
    [_TotalServerMemoryBytes]  BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_MemoryManager_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_MemoryManager_UnstableSamples_AzureSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

