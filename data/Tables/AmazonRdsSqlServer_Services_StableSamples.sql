CREATE TABLE [data].[AmazonRdsSqlServer_Services_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_ServiceState]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Startup]       NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [AmazonRdsSqlServer_Services_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Services_StableSamples_AmazonRdsSqlServer_Services_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Services_Keys] ([Id]) ON DELETE CASCADE
);

