CREATE TYPE [data].[Cluster_Machine_VMware_UnstableSamples_Type] AS TABLE (
    [Id]                    BIGINT     NOT NULL,
    [CollectionDate]        BIGINT     NOT NULL,
    [_CpuCostop]            BIGINT     NULL,
    [_CpuUsage]             BIGINT     NULL,
    [_DiskLatency]          BIGINT     NULL,
    [_DiskRead]             BIGINT     NULL,
    [_DiskWrite]            BIGINT     NULL,
    [_GuestCpuReady]        FLOAT (53) NULL,
    [_GuestCpuSwapWait]     FLOAT (53) NULL,
    [_GuestMemoryBallooned] BIGINT     NULL,
    [_GuestMemoryLatency]   BIGINT     NULL,
    [_HostMemoryBallooned]  BIGINT     NULL,
    [_MemorySwapInRate]     BIGINT     NULL,
    [_MemorySwapOutRate]    BIGINT     NULL,
    [_MemoryUsage]          BIGINT     NULL,
    [_NetworkUsage]         BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

