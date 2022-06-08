CREATE TABLE [data].[Cluster_SqlServer_Process_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Id]            BIGINT         NULL,
    [_Name]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_StartDate]     BIGINT         NULL,
    CONSTRAINT [Cluster_SqlServer_Process_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Process_StableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

