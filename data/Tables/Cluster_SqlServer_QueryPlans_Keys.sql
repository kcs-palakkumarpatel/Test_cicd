CREATE TABLE [data].[Cluster_SqlServer_QueryPlans_Keys] (
    [Id]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NOT NULL,
    [_PlanHandle]    VARBINARY (900) NOT NULL,
    CONSTRAINT [Cluster_SqlServer_QueryPlans_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_QueryPlans_Keys_Cluster_SqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_QueryPlans_Keys_ParentId__CreateDate__PlanHandle] UNIQUE NONCLUSTERED ([ParentId] ASC, [_CreateDate] ASC, [_PlanHandle] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_QueryPlans_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_QueryPlans_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

