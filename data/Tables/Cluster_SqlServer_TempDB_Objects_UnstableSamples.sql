CREATE TABLE [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_ReservedBytes] BIGINT NULL,
    [_RowCount]      BIGINT NULL,
    [_UsedBytes]     BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_TempDB_Objects_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TempDB_Objects_UnstableSamples_Cluster_SqlServer_TempDB_Objects_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_TempDB_Objects_Keys] ([Id]) ON DELETE CASCADE
);

