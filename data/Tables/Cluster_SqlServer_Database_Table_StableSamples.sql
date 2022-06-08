CREATE TABLE [data].[Cluster_SqlServer_Database_Table_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_CreateDate]    BIGINT NULL,
    [_ModifyDate]    BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Table_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Table_StableSamples_Cluster_SqlServer_Database_Table_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Table_Keys] ([Id]) ON DELETE CASCADE
);

