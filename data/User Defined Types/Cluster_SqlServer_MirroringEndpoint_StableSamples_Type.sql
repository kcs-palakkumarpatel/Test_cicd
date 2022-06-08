CREATE TYPE [data].[Cluster_SqlServer_MirroringEndpoint_StableSamples_Type] AS TABLE (
    [Id]                   BIGINT         NOT NULL,
    [CollectionDate]       BIGINT         NOT NULL,
    [_EncryptionAlgorithm] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_EncryptionEnabled]   BIT            NULL,
    [_Role]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

