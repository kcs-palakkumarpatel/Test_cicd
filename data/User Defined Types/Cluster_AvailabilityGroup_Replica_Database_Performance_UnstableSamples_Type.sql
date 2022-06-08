CREATE TYPE [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples_Type] AS TABLE (
    [Id]                                   BIGINT NOT NULL,
    [CollectionDate]                       BIGINT NOT NULL,
    [_CumulativeLogBytesReceivedPerSecond] BIGINT NULL,
    [_CumulativeRedoneBytesPerSecond]      BIGINT NULL,
    [_CumulativeTransactionDelay]          BIGINT NULL,
    [_LogSendQueue]                        BIGINT NULL,
    [_RecoveryQueue]                       BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

