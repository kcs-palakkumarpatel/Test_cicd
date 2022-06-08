CREATE TABLE [data].[AmazonRdsSqlServer_Network_Capacity_StableSamples] (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_BandwidthBitsPerSecond] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Network_Capacity_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Network_Capacity_StableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

