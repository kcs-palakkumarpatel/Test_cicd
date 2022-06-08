CREATE TABLE [data].[AmazonRdsSqlServer_TempDB_Files_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_FreeBytes]         BIGINT NULL,
    [_InternalBytes]     BIGINT NULL,
    [_MixedBytes]        BIGINT NULL,
    [_UserBytes]         BIGINT NULL,
    [_VersionStoreBytes] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Files_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Files_UnstableSamples_AmazonRdsSqlServer_TempDB_Files_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TempDB_Files_Keys] ([Id]) ON DELETE CASCADE
);

