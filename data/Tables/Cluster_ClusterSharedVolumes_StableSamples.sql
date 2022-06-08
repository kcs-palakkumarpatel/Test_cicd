CREATE TABLE [data].[Cluster_ClusterSharedVolumes_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_MountPoints]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_TotalBytes]    BIGINT         NULL,
    [_VolumeLabel]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_ClusterSharedVolumes_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_ClusterSharedVolumes_StableSamples_Cluster_ClusterSharedVolumes_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_ClusterSharedVolumes_Keys] ([Id]) ON DELETE CASCADE
);

