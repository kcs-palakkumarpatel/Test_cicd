CREATE TYPE [data].[AmazonRdsSqlServer_AccessMethods_UnstableSamples_Type] AS TABLE (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeFullScans]  BIGINT NULL,
    [_CumulativePageSplits] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

