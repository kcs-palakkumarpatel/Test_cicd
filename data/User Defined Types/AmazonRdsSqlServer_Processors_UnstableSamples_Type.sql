CREATE TYPE [data].[AmazonRdsSqlServer_Processors_UnstableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_CumulativeIdleTime] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

