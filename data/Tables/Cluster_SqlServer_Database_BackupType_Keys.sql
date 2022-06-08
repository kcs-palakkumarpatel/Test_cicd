CREATE TABLE [data].[Cluster_SqlServer_Database_BackupType_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Type]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Keys_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Keys_ParentId__Type] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Type] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_Database_BackupType_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_Database_BackupType_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

