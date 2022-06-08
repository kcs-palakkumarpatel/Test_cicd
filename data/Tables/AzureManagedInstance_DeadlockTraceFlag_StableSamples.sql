CREATE TABLE [data].[AzureManagedInstance_DeadlockTraceFlag_StableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_DeadlockTraceFlag] BIT    NULL,
    CONSTRAINT [AzureManagedInstance_DeadlockTraceFlag_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_DeadlockTraceFlag_StableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

