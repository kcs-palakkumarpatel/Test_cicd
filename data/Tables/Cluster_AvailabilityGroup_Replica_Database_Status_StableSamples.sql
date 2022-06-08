CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Database_Status_StableSamples] (
    [Id]                            BIGINT NOT NULL,
    [CollectionDate]                BIGINT NOT NULL,
    [_DatabaseState]                BIGINT NULL,
    [_DatabaseSynchronizationState] BIGINT NULL,
    [_IsDatabaseJoined]             BIGINT NULL,
    [_IsFailoverReady]              BIGINT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Database_Status_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Database_Status_StableSamples_Cluster_AvailabilityGroup_Replica_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Database_Keys] ([Id]) ON DELETE CASCADE
);

