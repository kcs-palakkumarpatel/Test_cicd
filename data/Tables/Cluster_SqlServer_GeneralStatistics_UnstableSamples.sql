CREATE TABLE [data].[Cluster_SqlServer_GeneralStatistics_UnstableSamples] (
    [Id]               BIGINT NOT NULL,
    [CollectionDate]   BIGINT NOT NULL,
    [_UserConnections] BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_GeneralStatistics_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_GeneralStatistics_UnstableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

