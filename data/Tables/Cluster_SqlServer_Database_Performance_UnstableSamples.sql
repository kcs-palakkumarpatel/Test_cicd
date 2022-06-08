CREATE TABLE [data].[Cluster_SqlServer_Database_Performance_UnstableSamples] (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_ActiveTransactions]        BIGINT NULL,
    [_CumulativeLogBytesFlushed] BIGINT NULL,
    [_CumulativeLogFlushes]      BIGINT NULL,
    [_CumulativeLogFlushWaits]   BIGINT NULL,
    [_CumulativeTransactions]    BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Performance_UnstableSamples_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

