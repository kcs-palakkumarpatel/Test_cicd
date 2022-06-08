CREATE TYPE [data].[Cluster_Machine_Security_CommunicationProtocol_StableSamples_Type] AS TABLE (
    [Id]                       BIGINT NOT NULL,
    [CollectionDate]           BIGINT NOT NULL,
    [_ClientDisabledByDefault] BIT    NULL,
    [_ClientEnabled]           BIT    NULL,
    [_ServerDisabledByDefault] BIT    NULL,
    [_ServerEnabled]           BIT    NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

