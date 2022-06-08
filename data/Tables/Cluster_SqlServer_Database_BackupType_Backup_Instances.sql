CREATE TABLE [data].[Cluster_SqlServer_Database_BackupType_Backup_Instances] (
    [Id]                   BIGINT         NOT NULL,
    [CollectionDate]       BIGINT         NOT NULL,
    [_BackupDevice]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_BackupSize]          BIGINT         NULL,
    [_DeviceName]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_FinishDate]          BIGINT         NULL,
    [_IsCompressed]        BIT            NULL,
    [_IsCopyOnly]          BIT            NULL,
    [_IsEncrypted]         BIT            NULL,
    [_IsNativeBackup]      BIT            NULL,
    [_IsPasswordProtected] BIT            NULL,
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Backup_Instances_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_BackupType_Backup_Instances_Cluster_SqlServer_Database_BackupType_Backup_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_BackupType_Backup_Keys] ([Id]) ON DELETE CASCADE
);

