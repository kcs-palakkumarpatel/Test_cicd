CREATE TYPE [data].[Cluster_AvailabilityGroup_Replica_Info_StableSamples_Type] AS TABLE (
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
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

