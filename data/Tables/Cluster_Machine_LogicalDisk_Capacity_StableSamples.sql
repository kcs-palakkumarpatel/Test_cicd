CREATE TABLE [data].[Cluster_Machine_LogicalDisk_Capacity_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_TotalBytes]    BIGINT NULL,
    CONSTRAINT [Cluster_Machine_LogicalDisk_Capacity_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_LogicalDisk_Capacity_StableSamples_Cluster_Machine_LogicalDisk_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_LogicalDisk_Keys] ([Id]) ON DELETE CASCADE
);

