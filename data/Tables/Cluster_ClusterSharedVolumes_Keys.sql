CREATE TABLE [data].[Cluster_ClusterSharedVolumes_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_VolumeGuid]    NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_ClusterSharedVolumes_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_ClusterSharedVolumes_Keys_Cluster_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_ClusterSharedVolumes_Keys_ParentId__VolumeGuid] UNIQUE NONCLUSTERED ([ParentId] ASC, [_VolumeGuid] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_ClusterSharedVolumes_Keys_CollectionDate]
    ON [data].[Cluster_ClusterSharedVolumes_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

