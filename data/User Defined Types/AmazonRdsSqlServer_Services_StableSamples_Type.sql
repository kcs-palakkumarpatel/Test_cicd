CREATE TYPE [data].[AmazonRdsSqlServer_Services_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ServiceState]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Startup]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

