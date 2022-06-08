CREATE TABLE [data].[AmazonRdsSqlServer_Database_Storage_UnstableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_TotalDataUsedBytes] BIGINT NULL,
    [_TotalLogUsedBytes]  BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Storage_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Storage_UnstableSamples_AmazonRdsSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

