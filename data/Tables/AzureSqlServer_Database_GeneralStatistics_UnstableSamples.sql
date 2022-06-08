CREATE TABLE [data].[AzureSqlServer_Database_GeneralStatistics_UnstableSamples] (
    [Id]               BIGINT NOT NULL,
    [CollectionDate]   BIGINT NOT NULL,
    [_UserConnections] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_GeneralStatistics_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_GeneralStatistics_UnstableSamples_AzureSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

