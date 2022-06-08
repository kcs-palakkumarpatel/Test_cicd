CREATE TYPE [data].[Cluster_ResourceGroup_Resource_StableSamples_Type] AS TABLE (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Description]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_State]         BIGINT         NULL,
    [_Type]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

