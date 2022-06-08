CREATE TYPE [data].[Cluster_SqlServer_Network_TcpEndpoint_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Active]        BIT            NULL,
    [_DynamicPorts]  BIGINT         NULL,
    [_Enabled]       BIT            NULL,
    [_IpAddress]     NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Port]          BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

