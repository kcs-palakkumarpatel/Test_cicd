CREATE TABLE [data].[AzureManagedInstance_Database_BackupType_Backup_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_StartDate]     BIGINT NOT NULL,
    CONSTRAINT [AzureManagedInstance_Database_BackupType_Backup_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_BackupType_Backup_Keys_AzureManagedInstance_Database_BackupType_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AzureManagedInstance_Database_BackupType_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AzureManagedInstance_Database_BackupType_Backup_Keys_ParentId__StartDate] UNIQUE NONCLUSTERED ([ParentId] ASC, [_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AzureManagedInstance_Database_BackupType_Backup_Keys__StartDate]
    ON [data].[AzureManagedInstance_Database_BackupType_Backup_Keys]([_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE);

