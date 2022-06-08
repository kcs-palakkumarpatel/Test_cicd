CREATE TABLE [data].[Cluster_Machine_Security_CommunicationProtocol_StableSamples] (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_ClientDisabledByDefault] BIT    NULL,
    [_ClientEnabled]           BIT    NULL,
    [_ServerDisabledByDefault] BIT    NULL,
    [_ServerEnabled]           BIT    NULL,
    CONSTRAINT [Cluster_Machine_Security_CommunicationProtocol_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Security_CommunicationProtocol_StableSamples_Cluster_Machine_Security_CommunicationProtocol_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Security_CommunicationProtocol_Keys] ([Id]) ON DELETE CASCADE
);

