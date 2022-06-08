CREATE TYPE [data].[Cluster_SqlServer_Database_Encryption_StableSamples_Type] AS TABLE (
    [Id]               BIGINT         NOT NULL,
    [CollectionDate]   BIGINT         NOT NULL,
    [_EncryptionState] NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

