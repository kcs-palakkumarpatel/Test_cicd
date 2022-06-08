CREATE TABLE [data].[AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_WaitTime]      BIGINT NULL,
    [_WaitTimeCount] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_TopQueries_QueryWaitStats_UnstableSamples_AzureManagedInstance_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

