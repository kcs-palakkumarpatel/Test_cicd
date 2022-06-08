CREATE TABLE [data].[Cluster_SqlServer_TopQueries_StableSamples] (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    [_QueryHash]     VARBINARY (MAX) NULL,
    [_QueryPlanHash] VARBINARY (MAX) NULL,
    CONSTRAINT [Cluster_SqlServer_TopQueries_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TopQueries_StableSamples_Cluster_SqlServer_TopQueries_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_TopQueries_Keys] ([Id]) ON DELETE CASCADE
);

