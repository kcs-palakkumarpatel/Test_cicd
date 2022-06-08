CREATE TYPE [data].[AzureManagedInstance_Resources_UnstableSamples_Type] AS TABLE (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeIdleTime]   BIGINT NULL,
    [_CumulativeReadBytes]  BIGINT NULL,
    [_CumulativeTransfers]  BIGINT NULL,
    [_CumulativeWriteBytes] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

