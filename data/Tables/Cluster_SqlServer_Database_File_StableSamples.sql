CREATE TABLE [data].[Cluster_SqlServer_Database_File_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_FileGroupName] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FileName]      NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_GrowthBytes]   BIGINT         NULL,
    [_GrowthPercent] FLOAT (53)     NULL,
    [_MaxSize]       BIGINT         NULL,
    CONSTRAINT [Cluster_SqlServer_Database_File_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_File_StableSamples_Cluster_SqlServer_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

