CREATE TYPE [data].[AzureManagedInstance_BufferManager_UnstableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_FreeListStalls]     BIGINT NULL,
    [_PageLifeExpectancy] BIGINT NULL,
    [_PageReads]          BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

