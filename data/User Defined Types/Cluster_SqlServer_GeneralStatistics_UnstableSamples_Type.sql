CREATE TYPE [data].[Cluster_SqlServer_GeneralStatistics_UnstableSamples_Type] AS TABLE (
    [Id]               BIGINT NOT NULL,
    [CollectionDate]   BIGINT NOT NULL,
    [_UserConnections] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

