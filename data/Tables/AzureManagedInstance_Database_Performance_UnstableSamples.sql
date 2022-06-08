CREATE TABLE [data].[AzureManagedInstance_Database_Performance_UnstableSamples] (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_ActiveTransactions]        BIGINT NULL,
    [_CumulativeLogBytesFlushed] BIGINT NULL,
    [_CumulativeLogFlushes]      BIGINT NULL,
    [_CumulativeLogFlushWaits]   BIGINT NULL,
    [_CumulativeTransactions]    BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Database_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Database_Performance_UnstableSamples_AzureManagedInstance_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Database_Keys] ([Id]) ON DELETE CASCADE
);

