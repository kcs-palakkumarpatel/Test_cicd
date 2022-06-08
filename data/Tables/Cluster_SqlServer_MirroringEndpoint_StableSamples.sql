CREATE TABLE [data].[Cluster_SqlServer_MirroringEndpoint_StableSamples] (
    [Id]                   BIGINT         NOT NULL,
    [CollectionDate]       BIGINT         NOT NULL,
    [_EncryptionAlgorithm] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_EncryptionEnabled]   BIT            NULL,
    [_Role]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_MirroringEndpoint_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_MirroringEndpoint_StableSamples_Cluster_SqlServer_MirroringEndpoint_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_MirroringEndpoint_Keys] ([Id]) ON DELETE CASCADE
);

