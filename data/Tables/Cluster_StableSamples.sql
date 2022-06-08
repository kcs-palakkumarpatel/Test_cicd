CREATE TABLE [data].[Cluster_StableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_IsReachable]              BIT    NULL,
    [_IsReadyForDataCollection] BIT    NULL,
    [_MonitoredEntityState]     BIGINT NULL,
    [_MonitoringStatusCategory] BIGINT NULL,
    CONSTRAINT [Cluster_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_StableSamples_Cluster_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Keys] ([Id]) ON DELETE CASCADE
);

