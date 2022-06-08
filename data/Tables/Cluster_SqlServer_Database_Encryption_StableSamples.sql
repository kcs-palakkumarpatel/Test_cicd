CREATE TABLE [data].[Cluster_SqlServer_Database_Encryption_StableSamples] (
    [Id]               BIGINT         NOT NULL,
    [CollectionDate]   BIGINT         NOT NULL,
    [_EncryptionState] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Encryption_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Encryption_StableSamples_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

