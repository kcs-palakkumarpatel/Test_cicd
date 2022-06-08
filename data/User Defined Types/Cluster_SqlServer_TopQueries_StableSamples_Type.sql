CREATE TYPE [data].[Cluster_SqlServer_TopQueries_StableSamples_Type] AS TABLE (
    [Id]             BIGINT          NOT NULL,
    [CollectionDate] BIGINT          NOT NULL,
    [_CreateDate]    BIGINT          NULL,
    [_PlanHandle]    VARBINARY (MAX) NULL,
    [_QueryHash]     VARBINARY (MAX) NULL,
    [_QueryPlanHash] VARBINARY (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

