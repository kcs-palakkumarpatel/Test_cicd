CREATE TYPE [data].[AzureSqlServer_Database_SqlStatistics_UnstableSamples_Type] AS TABLE (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativeBatchRequests]  BIGINT NULL,
    [_CumulativeCompilations]   BIGINT NULL,
    [_CumulativeRecompilations] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

