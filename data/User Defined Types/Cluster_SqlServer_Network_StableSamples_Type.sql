CREATE TYPE [data].[Cluster_SqlServer_Network_StableSamples_Type] AS TABLE (
    [Id]                   BIGINT NOT NULL,
    [CollectionDate]       BIGINT NOT NULL,
    [_NamedPipesEnabled]   BIT    NULL,
    [_SharedMemoryEnabled] BIT    NULL,
    [_TcpIpEnabled]        BIT    NULL,
    [_TcpListenAll]        BIT    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

