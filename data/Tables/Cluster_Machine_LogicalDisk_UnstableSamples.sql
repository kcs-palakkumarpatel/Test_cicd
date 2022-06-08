CREATE TABLE [data].[Cluster_Machine_LogicalDisk_UnstableSamples] (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeIdleTime]   BIGINT NULL,
    [_CumulativeReadBytes]  BIGINT NULL,
    [_CumulativeReads]      BIGINT NULL,
    [_CumulativeReadTime]   BIGINT NULL,
    [_CumulativeWriteBytes] BIGINT NULL,
    [_CumulativeWrites]     BIGINT NULL,
    [_CumulativeWriteTime]  BIGINT NULL,
    CONSTRAINT [Cluster_Machine_LogicalDisk_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_LogicalDisk_UnstableSamples_Cluster_Machine_LogicalDisk_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_LogicalDisk_Keys] ([Id]) ON DELETE CASCADE
);

