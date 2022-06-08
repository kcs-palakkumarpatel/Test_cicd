CREATE TYPE [data].[Cluster_AvailabilityGroup_Replica_Database_Status_StableSamples_Type] AS TABLE (
    [Id]                            BIGINT NOT NULL,
    [CollectionDate]                BIGINT NOT NULL,
    [_DatabaseState]                BIGINT NULL,
    [_DatabaseSynchronizationState] BIGINT NULL,
    [_IsDatabaseJoined]             BIGINT NULL,
    [_IsFailoverReady]              BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

