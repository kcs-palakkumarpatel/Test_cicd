CREATE TYPE [data].[Cluster_ClusterSharedVolumes_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_MountPoints]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_TotalBytes]    BIGINT         NULL,
    [_VolumeLabel]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

