CREATE TYPE [data].[AzureSqlServer_Database_CustomMetric_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ErrorMessage]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

