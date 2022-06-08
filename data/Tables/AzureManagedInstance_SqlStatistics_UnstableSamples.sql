CREATE TABLE [data].[AzureManagedInstance_SqlStatistics_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeBatchRequests]  BIGINT NULL,
    [_CumulativeCompilations]   BIGINT NULL,
    [_CumulativeRecompilations] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_SqlStatistics_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_SqlStatistics_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

