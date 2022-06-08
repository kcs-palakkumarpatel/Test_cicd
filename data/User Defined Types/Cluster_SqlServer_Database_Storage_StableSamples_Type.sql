CREATE TYPE [data].[Cluster_SqlServer_Database_Storage_StableSamples_Type] AS TABLE (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_TotalDataSizeBytes] BIGINT NULL,
    [_TotalLogSizeBytes]  BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

