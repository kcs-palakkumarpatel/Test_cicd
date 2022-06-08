CREATE TABLE [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Active]        BIT            NULL,
    [_DynamicPorts]  BIGINT         NULL,
    [_Enabled]       BIT            NULL,
    [_IpAddress]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Port]          BIGINT         NULL,
    CONSTRAINT [Cluster_SqlServer_Network_TcpEndpoint_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Network_TcpEndpoint_StableSamples_Cluster_SqlServer_Network_TcpEndpoint_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Network_TcpEndpoint_Keys] ([Id]) ON DELETE CASCADE
);

