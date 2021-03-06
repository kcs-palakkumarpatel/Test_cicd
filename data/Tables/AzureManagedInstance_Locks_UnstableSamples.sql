CREATE TABLE [data].[AzureManagedInstance_Locks_UnstableSamples] (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_CumulativeDeadlocks]    BIGINT NULL,
    [_CumulativeLockTimeouts] BIGINT NULL,
    [_CumulativeLockWaits]    BIGINT NULL,
    [_CumulativeLockWaitTime] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Locks_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Locks_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

