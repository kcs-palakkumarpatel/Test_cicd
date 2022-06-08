CREATE TABLE [data].[AmazonRdsSqlServer_TempDB_Distribution_UnstableSamples] (
    [Id]                BIGINT NOT NULL,
    [CollectionDate]    BIGINT NOT NULL,
    [_FreeBytes]        BIGINT NULL,
    [_InternalBytes]    BIGINT NULL,
    [_MixedExtentBytes] BIGINT NULL,
    [_UserObjectBytes]  BIGINT NULL,
    [_VersionBytes]     BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Distribution_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Distribution_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

