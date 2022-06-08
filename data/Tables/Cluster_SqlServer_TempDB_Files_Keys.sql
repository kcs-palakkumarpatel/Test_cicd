CREATE TABLE [data].[Cluster_SqlServer_TempDB_Files_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_FileName]      NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_SqlServer_TempDB_Files_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TempDB_Files_Keys_Cluster_SqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_TempDB_Files_Keys_ParentId__FileName] UNIQUE NONCLUSTERED ([ParentId] ASC, [_FileName] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_TempDB_Files_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_TempDB_Files_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

