CREATE TABLE [data].[AmazonRdsSqlServer_AccessMethods_UnstableSamples] (
    [Id]                    BIGINT NOT NULL,
    [CollectionDate]        BIGINT NOT NULL,
    [_CumulativeFullScans]  BIGINT NULL,
    [_CumulativePageSplits] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_AccessMethods_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_AccessMethods_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

