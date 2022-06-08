CREATE TYPE [data].[Cluster_Machine_Properties_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_DnsHostName]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Domain]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

