CREATE TABLE [data].[AzureManagedInstance_Process_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativePrivilegedTime] BIGINT NULL,
    [_CumulativeUserTime]       BIGINT NULL,
    [_PrivateBytes]             BIGINT NULL,
    [_VirtualBytes]             BIGINT NULL,
    [_WorkingSet]               BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Process_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Process_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

