CREATE TABLE [data].[AzureManagedInstance_TempDB_VersionStore_UnstableSamples] (
    [Id]                             BIGINT NOT NULL,
    [CollectionDate]                 BIGINT NOT NULL,
    [_CumulativeCleanupRate]         BIGINT NULL,
    [_CumulativeGenerationRate]      BIGINT NULL,
    [_LongestRunningTransactionTime] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_TempDB_VersionStore_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_TempDB_VersionStore_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

