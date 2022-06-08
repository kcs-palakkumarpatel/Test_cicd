CREATE TYPE [data].[Cluster_SqlServer_TempDB_VersionStore_UnstableSamples_Type] AS TABLE (
    [Id]                             BIGINT NOT NULL,
    [CollectionDate]                 BIGINT NOT NULL,
    [_CumulativeCleanupRate]         BIGINT NULL,
    [_CumulativeGenerationRate]      BIGINT NULL,
    [_LongestRunningTransactionTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

