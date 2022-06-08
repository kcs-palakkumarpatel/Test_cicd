CREATE TYPE [data].[Cluster_AvailabilityGroup_Replica_Status_StableSamples_Type] AS TABLE (
    [Id]                BIGINT NOT NULL,
    [CollectionDate]    BIGINT NOT NULL,
    [_OperationalState] BIGINT NULL,
    [_RecoveryHealth]   BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

