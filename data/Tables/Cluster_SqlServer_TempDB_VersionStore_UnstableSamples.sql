CREATE TABLE [data].[Cluster_SqlServer_TempDB_VersionStore_UnstableSamples] (
    [Id]                             BIGINT NOT NULL,
    [CollectionDate]                 BIGINT NOT NULL,
    [_CumulativeCleanupRate]         BIGINT NULL,
    [_CumulativeGenerationRate]      BIGINT NULL,
    [_LongestRunningTransactionTime] BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_TempDB_VersionStore_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TempDB_VersionStore_UnstableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

