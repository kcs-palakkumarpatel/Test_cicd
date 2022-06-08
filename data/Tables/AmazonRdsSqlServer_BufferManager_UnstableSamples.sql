CREATE TABLE [data].[AmazonRdsSqlServer_BufferManager_UnstableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_FreeListStalls]     BIGINT NULL,
    [_PageLifeExpectancy] BIGINT NULL,
    [_PageReads]          BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_BufferManager_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_BufferManager_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

