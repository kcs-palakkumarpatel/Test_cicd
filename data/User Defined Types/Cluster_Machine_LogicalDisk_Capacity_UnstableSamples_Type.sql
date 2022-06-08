CREATE TYPE [data].[Cluster_Machine_LogicalDisk_Capacity_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_FreeBytes]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

