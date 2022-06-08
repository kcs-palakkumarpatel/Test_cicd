CREATE TABLE [data].[AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_LastIntegrityCheck] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples_AmazonRdsSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

