CREATE TABLE [data].[AzureManagedInstance_BufferManager_UnstableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_FreeListStalls]     BIGINT NULL,
    [_PageLifeExpectancy] BIGINT NULL,
    [_PageReads]          BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_BufferManager_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_BufferManager_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

