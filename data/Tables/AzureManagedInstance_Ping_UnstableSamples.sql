CREATE TABLE [data].[AzureManagedInstance_Ping_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_RoundtripTime] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_Ping_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_Ping_UnstableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

