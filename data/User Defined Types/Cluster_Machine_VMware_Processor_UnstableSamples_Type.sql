CREATE TYPE [data].[Cluster_Machine_VMware_Processor_UnstableSamples_Type] AS TABLE (
    [Id]                   BIGINT NOT NULL,
    [CollectionDate]       BIGINT NOT NULL,
    [_EffectiveVmSpeedMhz] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

