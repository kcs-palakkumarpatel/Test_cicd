CREATE TABLE [data].[Cluster_SqlServer_SqlProcess_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_LoginTime]     BIGINT NOT NULL,
    [_SessionId]     BIGINT NOT NULL,
    CONSTRAINT [Cluster_SqlServer_SqlProcess_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_SqlProcess_Keys_Cluster_SqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_SqlProcess_Keys_ParentId__LoginTime__SessionId] UNIQUE NONCLUSTERED ([ParentId] ASC, [_LoginTime] ASC, [_SessionId] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_SqlProcess_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_SqlProcess_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

