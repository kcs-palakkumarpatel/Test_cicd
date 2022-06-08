CREATE TYPE [data].[Cluster_Machine_Security_StableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_FipsEnabled]   BIT    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

