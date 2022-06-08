CREATE TYPE [data].[Cluster_Machine_VMware_Processor_StableSamples_Type] AS TABLE (
    [Id]                     BIGINT NOT NULL,
    [CollectionDate]         BIGINT NOT NULL,
    [_CpuLimitMhz]           BIGINT NULL,
    [_CpuReservationMhz]     BIGINT NULL,
    [_CpuShares]             BIGINT NULL,
    [_HostProcessorSpeedMhz] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

