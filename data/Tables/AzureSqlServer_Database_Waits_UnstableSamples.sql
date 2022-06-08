CREATE TABLE [data].[AzureSqlServer_Database_Waits_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_SignalWaitTime]    BIGINT NULL,
    [_WaitingTasksCount] BIGINT NULL,
    [_WaitTime]          BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_Waits_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_Waits_UnstableSamples_AzureSqlServer_Database_Waits_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Waits_Keys] ([Id]) ON DELETE CASCADE
);

