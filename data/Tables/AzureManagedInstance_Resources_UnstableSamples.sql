CREATE TABLE [data].[AzureManagedInstance_Resources_UnstableSamples] (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeIdleTime]   BIGINT NULL,
    [_CumulativeReadBytes]  BIGINT NULL,
    [_CumulativeTransfers]  BIGINT NULL,
    [_CumulativeWriteBytes] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Resources_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Resources_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

