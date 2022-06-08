CREATE TYPE [data].[Cluster_Machine_Memory_UnstableSamples_Type] AS TABLE (
    [Id]                     BIGINT NOT NULL,
    [CollectionDate]         BIGINT NOT NULL,
    [_CumulativePagesInput]  BIGINT NULL,
    [_CumulativePagesOutput] BIGINT NULL,
    [_FreeBytes]             BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

