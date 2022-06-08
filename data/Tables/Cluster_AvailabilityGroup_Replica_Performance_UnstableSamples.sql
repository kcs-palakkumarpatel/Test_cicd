CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Performance_UnstableSamples] (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_CumulativeFlowControlTime] BIGINT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Performance_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Performance_UnstableSamples_Cluster_AvailabilityGroup_Replica_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Keys] ([Id]) ON DELETE CASCADE
);

