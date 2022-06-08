CREATE TYPE [data].[AmazonRdsSqlServer_Permissions_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Data]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

