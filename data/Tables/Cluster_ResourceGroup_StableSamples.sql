CREATE TABLE [data].[Cluster_ResourceGroup_StableSamples] (
    [Id]             BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Description]   NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Node]          NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_State]         BIGINT         NULL,
    CONSTRAINT [Cluster_ResourceGroup_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_ResourceGroup_StableSamples_Cluster_ResourceGroup_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_ResourceGroup_Keys] ([Id]) ON DELETE CASCADE
);

