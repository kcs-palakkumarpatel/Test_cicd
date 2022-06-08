CREATE TYPE [data].[Cluster_SqlServer_StableSamples_Type] AS TABLE (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_IsReachable]              BIT    NULL,
    [_IsReadyForDataCollection] BIT    NULL,
    [_MonitoredEntityState]     BIGINT NULL,
    [_MonitoringStatusCategory] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

