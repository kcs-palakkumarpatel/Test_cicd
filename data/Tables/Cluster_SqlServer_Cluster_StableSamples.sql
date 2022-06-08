CREATE TABLE [data].[Cluster_SqlServer_Cluster_StableSamples] (
    [Id]                  BIGINT         NOT NULL,
    [CollectionDate]      BIGINT         NOT NULL,
    [_NodeName]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceGroupName]  NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ResourceGroupState] BIGINT         NULL,
    [_State]              BIGINT         NULL,
    CONSTRAINT [Cluster_SqlServer_Cluster_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Cluster_StableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

