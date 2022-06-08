CREATE TYPE [data].[AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_LastIntegrityCheck] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

