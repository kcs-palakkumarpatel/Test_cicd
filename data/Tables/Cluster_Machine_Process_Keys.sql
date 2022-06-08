CREATE TABLE [data].[Cluster_Machine_Process_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Id]            BIGINT NOT NULL,
    [_StartDate]     BIGINT NOT NULL,
    CONSTRAINT [Cluster_Machine_Process_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Process_Keys_Cluster_Machine_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_Machine_Process_Keys_ParentId__Id__StartDate] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Id] ASC, [_StartDate] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_Machine_Process_Keys_CollectionDate]
    ON [data].[Cluster_Machine_Process_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

