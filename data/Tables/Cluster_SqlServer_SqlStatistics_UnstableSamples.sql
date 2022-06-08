CREATE TABLE [data].[Cluster_SqlServer_SqlStatistics_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeBatchRequests]  BIGINT NULL,
    [_CumulativeCompilations]   BIGINT NULL,
    [_CumulativeRecompilations] BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_SqlStatistics_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_SqlStatistics_UnstableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

