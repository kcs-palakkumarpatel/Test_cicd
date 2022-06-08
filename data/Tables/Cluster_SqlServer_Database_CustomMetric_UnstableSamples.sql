CREATE TABLE [data].[Cluster_SqlServer_Database_CustomMetric_UnstableSamples] (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Value]         FLOAT (53) NULL,
    CONSTRAINT [Cluster_SqlServer_Database_CustomMetric_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_CustomMetric_UnstableSamples_Cluster_SqlServer_Database_CustomMetric_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_CustomMetric_Keys] ([Id]) ON DELETE CASCADE
);

