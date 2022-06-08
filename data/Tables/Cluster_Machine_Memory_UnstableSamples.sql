CREATE TABLE [data].[Cluster_Machine_Memory_UnstableSamples] (
    [Id]                     BIGINT NOT NULL,
    [CollectionDate]         BIGINT NOT NULL,
    [_CumulativePagesInput]  BIGINT NULL,
    [_CumulativePagesOutput] BIGINT NULL,
    [_FreeBytes]             BIGINT NULL,
    CONSTRAINT [Cluster_Machine_Memory_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Memory_UnstableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

