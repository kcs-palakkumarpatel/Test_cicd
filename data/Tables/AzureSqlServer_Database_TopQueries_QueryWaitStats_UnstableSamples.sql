CREATE TABLE [data].[AzureSqlServer_Database_TopQueries_QueryWaitStats_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_WaitTime]      BIGINT NULL,
    [_WaitTimeCount] BIGINT NULL,
    CONSTRAINT [AzureSqlServer_Database_TopQueries_QueryWaitStats_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_TopQueries_QueryWaitStats_UnstableSamples_AzureSqlServer_Database_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

