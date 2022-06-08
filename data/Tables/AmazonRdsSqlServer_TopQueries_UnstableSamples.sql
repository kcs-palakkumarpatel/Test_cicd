CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_UnstableSamples] (
    [Id]              BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_ExecutionCount] BIGINT NULL,
    [_ExecutionTime]  BIGINT NULL,
    [_LogicalReads]   BIGINT NULL,
    [_LogicalWrites]  BIGINT NULL,
    [_PhysicalReads]  BIGINT NULL,
    [_WorkerTime]     BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_UnstableSamples_AmazonRdsSqlServer_TopQueries_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_Keys] ([Id]) ON DELETE CASCADE
);

