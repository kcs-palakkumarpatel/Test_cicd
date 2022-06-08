CREATE TABLE [data].[Cluster_Machine_LogicalDisk_Volume_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_VolumePath]    NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_Machine_LogicalDisk_Volume_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_LogicalDisk_Volume_StableSamples_Cluster_Machine_LogicalDisk_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_LogicalDisk_Keys] ([Id]) ON DELETE CASCADE
);

