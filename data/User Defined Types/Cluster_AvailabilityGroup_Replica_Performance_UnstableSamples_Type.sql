CREATE TYPE [data].[Cluster_AvailabilityGroup_Replica_Performance_UnstableSamples_Type] AS TABLE (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_CumulativeFlowControlTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

