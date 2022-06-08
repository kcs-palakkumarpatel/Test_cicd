CREATE TABLE [data].[AmazonRdsSqlServer_Process_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Ppid]          BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Process_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Process_StableSamples_AmazonRdsSqlServer_Process_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Process_Keys] ([Id]) ON DELETE CASCADE
);

