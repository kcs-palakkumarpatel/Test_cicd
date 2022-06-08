CREATE TYPE [data].[Cluster_Machine_VMware_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_CpuCores]      BIGINT         NULL,
    [_CpuPackages]   BIGINT         NULL,
    [_CpuThreads]    BIGINT         NULL,
    [_HostMachine]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

