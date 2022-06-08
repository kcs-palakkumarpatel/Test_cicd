CREATE TYPE [data].[AzureManagedInstance_Locks_UnstableSamples_Type] AS TABLE (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_CumulativeDeadlocks]    BIGINT NULL,
    [_CumulativeLockTimeouts] BIGINT NULL,
    [_CumulativeLockWaits]    BIGINT NULL,
    [_CumulativeLockWaitTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

