CREATE TABLE [data].[Cluster_AvailabilityGroup_Listener_StableSamples] (
    [Id]                 BIGINT         NOT NULL,
    [CollectionDate]     BIGINT         NOT NULL,
    [_ListenerIpAddress] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ListenerPort]      BIGINT         NULL,
    [_ListenerState]     BIGINT         NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Listener_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Listener_StableSamples_Cluster_AvailabilityGroup_Listener_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Listener_Keys] ([Id]) ON DELETE CASCADE
);

