CREATE TABLE [data].[Cluster_AvailabilityGroup_Listener_Keys] (
    [Id]               BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]         BIGINT         NOT NULL,
    [CollectionDate]   BIGINT         NOT NULL,
    [_ListenerDnsName] NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Listener_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Listener_Keys_Cluster_AvailabilityGroup_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_AvailabilityGroup_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_AvailabilityGroup_Listener_Keys_ParentId__ListenerDnsName] UNIQUE NONCLUSTERED ([ParentId] ASC, [_ListenerDnsName] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_AvailabilityGroup_Listener_Keys_CollectionDate]
    ON [data].[Cluster_AvailabilityGroup_Listener_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

