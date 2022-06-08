CREATE TABLE [data].[Cluster_SqlServer_Database_File_Projection_UnstableSamples] (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Gradient]      FLOAT (53) NULL,
    [_Intercept]     FLOAT (53) NULL,
    CONSTRAINT [Cluster_SqlServer_Database_File_Projection_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_File_Projection_UnstableSamples_Cluster_SqlServer_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

