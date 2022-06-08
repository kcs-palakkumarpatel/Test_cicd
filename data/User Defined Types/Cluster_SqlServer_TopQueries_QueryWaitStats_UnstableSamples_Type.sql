CREATE TYPE [data].[Cluster_SqlServer_TopQueries_QueryWaitStats_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_WaitTime]      BIGINT NULL,
    [_WaitTimeCount] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

