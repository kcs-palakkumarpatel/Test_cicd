CREATE TABLE [data].[AmazonRdsSqlServer_TempDB_VersionStore_UnstableSamples] (
    [Id]                             BIGINT NOT NULL,
    [CollectionDate]                 BIGINT NOT NULL,
    [_CumulativeCleanupRate]         BIGINT NULL,
    [_CumulativeGenerationRate]      BIGINT NULL,
    [_LongestRunningTransactionTime] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_VersionStore_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TempDB_VersionStore_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

