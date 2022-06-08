CREATE TABLE [data].[AzureManagedInstance_StableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_IsReachable]              BIT    NULL,
    [_IsReadyForDataCollection] BIT    NULL,
    [_MonitoredEntityState]     BIGINT NULL,
    [_MonitoringStatusCategory] BIGINT NULL,
    CONSTRAINT [AzureManagedInstance_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureManagedInstance_StableSamples_AzureManagedInstance_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureManagedInstance_Keys] ([Id]) ON DELETE CASCADE
);

