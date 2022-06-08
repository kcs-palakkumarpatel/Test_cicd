CREATE TABLE [data].[AzureSqlServer_Database_CustomMetric_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ErrorMessage]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureSqlServer_Database_CustomMetric_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_CustomMetric_StableSamples_AzureSqlServer_Database_CustomMetric_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_CustomMetric_Keys] ([Id]) ON DELETE CASCADE
);

