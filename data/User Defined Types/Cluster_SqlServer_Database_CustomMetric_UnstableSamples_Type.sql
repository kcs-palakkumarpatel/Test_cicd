CREATE TYPE [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Value]         FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

