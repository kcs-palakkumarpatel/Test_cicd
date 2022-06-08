﻿CREATE TABLE [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_StartDate]     BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_BackupType_Backup_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_BackupType_Backup_Keys_AmazonRdsSqlServer_Database_BackupType_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Database_BackupType_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Database_BackupType_Backup_Keys_ParentId__StartDate] UNIQUE NONCLUSTERED ([ParentId] ASC, [_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Database_BackupType_Backup_Keys__StartDate]
    ON [data].[AmazonRdsSqlServer_Database_BackupType_Backup_Keys]([_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE);

