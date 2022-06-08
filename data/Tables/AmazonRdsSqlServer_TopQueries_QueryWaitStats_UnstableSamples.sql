CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_WaitTime]      BIGINT NULL,
    [_WaitTimeCount] BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_UnstableSamples_AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

