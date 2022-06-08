CREATE TABLE [data].[AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_DeadlockTraceFlag] BIT    NULL,
    CONSTRAINT [AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_DeadlockTraceFlag_StableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

