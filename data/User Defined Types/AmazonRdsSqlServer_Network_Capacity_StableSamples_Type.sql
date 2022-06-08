CREATE TYPE [data].[AmazonRdsSqlServer_Network_Capacity_StableSamples_Type] AS TABLE (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_BandwidthBitsPerSecond] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

