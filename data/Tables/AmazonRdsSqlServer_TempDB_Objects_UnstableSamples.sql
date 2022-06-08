CREATE TABLE [data].[AmazonRdsSqlServer_TempDB_Objects_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_ReservedBytes] BIGINT NULL,
    [_RowCount]      BIGINT NULL,
    [_UsedBytes]     BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Objects_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Objects_UnstableSamples_AmazonRdsSqlServer_TempDB_Objects_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TempDB_Objects_Keys] ([Id]) ON DELETE CASCADE
);

