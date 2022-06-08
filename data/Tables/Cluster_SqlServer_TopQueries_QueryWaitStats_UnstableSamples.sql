CREATE TABLE [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_WaitTime]      BIGINT NULL,
    [_WaitTimeCount] BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_TopQueries_QueryWaitStats_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TopQueries_QueryWaitStats_UnstableSamples_Cluster_SqlServer_TopQueries_QueryWaitStats_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_Keys] ([Id]) ON DELETE CASCADE
);

