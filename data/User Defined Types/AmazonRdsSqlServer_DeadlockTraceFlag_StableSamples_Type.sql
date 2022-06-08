CREATE TYPE [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples_Type] AS TABLE (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_DeadlockTraceFlag] BIT    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

