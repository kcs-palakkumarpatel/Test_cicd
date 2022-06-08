CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples] (
    [Id]                             BIGINT NOT NULL,
    [CollectionDate]                 BIGINT NOT NULL,
    [_AvailabilityMode]              BIGINT NULL,
    [_ConnectedState]                BIGINT NULL,
    [_FailoverMode]                  BIGINT NULL,
    [_JoinState]                     BIGINT NULL,
    [_PrimaryRoleAllowConnections]   BIGINT NULL,
    [_Role]                          BIGINT NULL,
    [_SecondaryRoleAllowConnections] BIGINT NULL,
    [_SynchronizationHealth]         BIGINT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Info_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Info_StableSamples_Cluster_AvailabilityGroup_Replica_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Keys] ([Id]) ON DELETE CASCADE
);

