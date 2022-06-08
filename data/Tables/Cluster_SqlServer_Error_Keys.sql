CREATE TABLE [data].[Cluster_SqlServer_Error_Keys] (
    [Id]              BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]        BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_LogDate]        BIGINT NOT NULL,
    [_SequenceNumber] BIGINT NOT NULL,
    CONSTRAINT [Cluster_SqlServer_Error_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Error_Keys_Cluster_SqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_Error_Keys_ParentId__LogDate__SequenceNumber] UNIQUE NONCLUSTERED ([ParentId] ASC, [_LogDate] ASC, [_SequenceNumber] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_Error_Keys__LogDate]
    ON [data].[Cluster_SqlServer_Error_Keys]([_LogDate] ASC) WITH (DATA_COMPRESSION = PAGE);

