CREATE TABLE [data].[Cluster_Machine_VMware_UnstableSamples] (
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
    CONSTRAINT [Cluster_Machine_VMware_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_VMware_UnstableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

