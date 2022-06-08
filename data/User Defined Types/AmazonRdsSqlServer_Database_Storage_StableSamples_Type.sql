CREATE TYPE [data].[AmazonRdsSqlServer_Database_Storage_StableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_TotalDataSizeBytes] BIGINT NULL,
    [_TotalLogSizeBytes]  BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

