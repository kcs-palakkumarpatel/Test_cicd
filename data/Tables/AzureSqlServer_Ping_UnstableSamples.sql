CREATE TABLE [data].[AzureSqlServer_Ping_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_RoundtripTime] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Ping_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Ping_UnstableSamples_AzureSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

