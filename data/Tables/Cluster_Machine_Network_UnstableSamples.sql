CREATE TABLE [data].[Cluster_Machine_Network_UnstableSamples] (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_CumulativeBytesReceived] BIGINT NULL,
    [_CumulativeBytesSent]     BIGINT NULL,
    CONSTRAINT [Cluster_Machine_Network_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Network_UnstableSamples_Cluster_Machine_Network_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Network_Keys] ([Id]) ON DELETE CASCADE
);

