CREATE TYPE [data].[AmazonRdsSqlServer_ConfigurationOptions_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Type]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Value]         NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

