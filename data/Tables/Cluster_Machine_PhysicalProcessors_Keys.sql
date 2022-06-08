CREATE TABLE [data].[Cluster_Machine_PhysicalProcessors_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_DeviceID]      NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_Machine_PhysicalProcessors_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_PhysicalProcessors_Keys_Cluster_Machine_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_Machine_PhysicalProcessors_Keys_ParentId__DeviceID] UNIQUE NONCLUSTERED ([ParentId] ASC, [_DeviceID] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_Machine_PhysicalProcessors_Keys_CollectionDate]
    ON [data].[Cluster_Machine_PhysicalProcessors_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

