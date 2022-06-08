CREATE TYPE [data].[AmazonRdsSqlServer_Database_Performance_UnstableSamples_Type] AS TABLE (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_ActiveTransactions]        BIGINT NULL,
    [_CumulativeLogBytesFlushed] BIGINT NULL,
    [_CumulativeLogFlushes]      BIGINT NULL,
    [_CumulativeLogFlushWaits]   BIGINT NULL,
    [_CumulativeTransactions]    BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

