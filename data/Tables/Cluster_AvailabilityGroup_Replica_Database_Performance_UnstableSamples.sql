CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples] (
    [Id]                                   BIGINT NOT NULL,
    [CollectionDate]                       BIGINT NOT NULL,
    [_CumulativeLogBytesReceivedPerSecond] BIGINT NULL,
    [_CumulativeRedoneBytesPerSecond]      BIGINT NULL,
    [_CumulativeTransactionDelay]          BIGINT NULL,
    [_LogSendQueue]                        BIGINT NULL,
    [_RecoveryQueue]                       BIGINT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Database_Performance_UnstableSamples_Cluster_AvailabilityGroup_Replica_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Database_Keys] ([Id]) ON DELETE CASCADE
);

