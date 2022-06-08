CREATE TABLE [data].[AzureSqlServer_Database_ConfigurationOptions_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Type]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Value]         NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AzureSqlServer_Database_ConfigurationOptions_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_ConfigurationOptions_StableSamples_AzureSqlServer_Database_ConfigurationOptions_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_ConfigurationOptions_Keys] ([Id]) ON DELETE CASCADE
);

