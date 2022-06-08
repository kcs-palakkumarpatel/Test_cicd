CREATE TABLE [data].[Cluster_SqlServer_Database_File_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Size]          BIGINT NULL,
    [_UsedSize]      BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_File_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_File_UnstableSamples_Cluster_SqlServer_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

