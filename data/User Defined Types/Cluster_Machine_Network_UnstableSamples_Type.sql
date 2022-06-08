CREATE TYPE [data].[Cluster_Machine_Network_UnstableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_CumulativeBytesReceived] BIGINT NULL,
    [_CumulativeBytesSent]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

