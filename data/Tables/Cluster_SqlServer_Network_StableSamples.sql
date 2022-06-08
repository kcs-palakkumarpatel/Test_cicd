CREATE TABLE [data].[Cluster_SqlServer_Network_StableSamples] (
    [Id]                   BIGINT NOT NULL,
    [CollectionDate]       BIGINT NOT NULL,
    [_NamedPipesEnabled]   BIT    NULL,
    [_SharedMemoryEnabled] BIT    NULL,
    [_TcpIpEnabled]        BIT    NULL,
    [_TcpListenAll]        BIT    NULL,
    CONSTRAINT [Cluster_SqlServer_Network_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Network_StableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

