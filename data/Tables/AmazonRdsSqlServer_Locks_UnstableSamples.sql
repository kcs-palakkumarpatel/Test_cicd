CREATE TABLE [data].[AmazonRdsSqlServer_Locks_UnstableSamples] (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_CumulativeDeadlocks]    BIGINT NULL,
    [_CumulativeLockTimeouts] BIGINT NULL,
    [_CumulativeLockWaits]    BIGINT NULL,
    [_CumulativeLockWaitTime] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Locks_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Locks_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

