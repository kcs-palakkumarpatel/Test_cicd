CREATE TYPE [data].[Cluster_Machine_PhysicalProcessors_StableSamples_Type] AS TABLE (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_NumberOfCores]             BIGINT NULL,
    [_NumberOfEnabledCore]       BIGINT NULL,
    [_NumberOfLogicalProcessors] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

