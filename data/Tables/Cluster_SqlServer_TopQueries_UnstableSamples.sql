CREATE TABLE [data].[Cluster_SqlServer_TopQueries_UnstableSamples] (
    [Id]              BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_ExecutionCount] BIGINT NULL,
    [_ExecutionTime]  BIGINT NULL,
    [_LogicalReads]   BIGINT NULL,
    [_LogicalWrites]  BIGINT NULL,
    [_PhysicalReads]  BIGINT NULL,
    [_WorkerTime]     BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_TopQueries_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TopQueries_UnstableSamples_Cluster_SqlServer_TopQueries_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_TopQueries_Keys] ([Id]) ON DELETE CASCADE
);

