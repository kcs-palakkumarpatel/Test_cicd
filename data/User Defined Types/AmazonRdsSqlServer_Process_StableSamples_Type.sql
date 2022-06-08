CREATE TYPE [data].[AmazonRdsSqlServer_Process_StableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Ppid]          BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

