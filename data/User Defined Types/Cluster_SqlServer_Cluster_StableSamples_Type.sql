CREATE TYPE [data].[Cluster_SqlServer_Cluster_StableSamples_Type] AS TABLE (
    [Id]                  BIGINT         NOT NULL,
    [CollectionDate]      BIGINT         NOT NULL,
    [_NodeName]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceGroupName]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceGroupState] BIGINT         NULL,
    [_State]              BIGINT         NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

