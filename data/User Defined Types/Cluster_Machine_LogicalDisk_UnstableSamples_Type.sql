CREATE TYPE [data].[Cluster_Machine_LogicalDisk_UnstableSamples_Type] AS TABLE (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeIdleTime]   BIGINT NULL,
    [_CumulativeReadBytes]  BIGINT NULL,
    [_CumulativeReads]      BIGINT NULL,
    [_CumulativeReadTime]   BIGINT NULL,
    [_CumulativeWriteBytes] BIGINT NULL,
    [_CumulativeWrites]     BIGINT NULL,
    [_CumulativeWriteTime]  BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

