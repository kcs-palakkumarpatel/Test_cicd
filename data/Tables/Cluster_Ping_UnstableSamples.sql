CREATE TABLE [data].[Cluster_Ping_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_RoundtripTime] BIGINT NULL,
    CONSTRAINT [Cluster_Ping_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Ping_UnstableSamples_Cluster_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Keys] ([Id]) ON DELETE CASCADE
);

