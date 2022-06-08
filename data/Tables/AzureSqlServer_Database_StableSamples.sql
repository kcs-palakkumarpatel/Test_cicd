CREATE TABLE [data].[AzureSqlServer_Database_StableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_IsReachable]              BIT    NULL,
    [_IsReadyForDataCollection] BIT    NULL,
    [_MonitoredEntityState]     BIGINT NULL,
    [_MonitoringStatusCategory] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_StableSamples_AzureSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

