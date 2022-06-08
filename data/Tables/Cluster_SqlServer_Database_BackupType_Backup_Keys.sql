CREATE TABLE [data].[Cluster_SqlServer_Database_BackupType_Backup_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_StartDate]     BIGINT NOT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Backup_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Backup_Keys_Cluster_SqlServer_Database_BackupType_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Database_BackupType_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Backup_Keys_ParentId__StartDate] UNIQUE NONCLUSTERED ([ParentId] ASC, [_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_Database_BackupType_Backup_Keys__StartDate]
    ON [data].[Cluster_SqlServer_Database_BackupType_Backup_Keys]([_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE);

