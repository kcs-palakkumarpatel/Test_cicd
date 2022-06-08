CREATE TABLE [data].[Cluster_ClusterSharedVolumes_Projection_UnstableSamples] (
    [Id]                 BIGINT     NOT NULL,
    [CollectionDate]     BIGINT     NOT NULL,
    [_EstimatedFullDate] BIGINT     NULL,
    [_SizeInOneYear]     FLOAT (53) NULL,
    [_SizeNow]           FLOAT (53) NULL,
    CONSTRAINT [Cluster_ClusterSharedVolumes_Projection_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_ClusterSharedVolumes_Projection_UnstableSamples_Cluster_ClusterSharedVolumes_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_ClusterSharedVolumes_Keys] ([Id]) ON DELETE CASCADE
);

