CREATE TABLE [data].[Cluster_SqlServer_TopQueries_Keys] (
    [Id]              BIGINT          IDENTITY (1, 1) NOT NULL,
    [ParentId]        BIGINT          NOT NULL,
    [CollectionDate]  BIGINT          NOT NULL,
    [_DatabaseName]   NVARCHAR (450)  COLLATE Latin1_General_BIN2 NOT NULL,
    [_SqlHandle]      VARBINARY (900) NOT NULL,
    [_StatementEnd]   BIGINT          NOT NULL,
    [_StatementStart] BIGINT          NOT NULL,
    CONSTRAINT [Cluster_SqlServer_TopQueries_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_TopQueries_Keys_Cluster_SqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_TopQueries_Keys_ParentId__DatabaseName__SqlHandle__StatementEnd__StatementStart] UNIQUE NONCLUSTERED ([ParentId] ASC, [_DatabaseName] ASC, [_SqlHandle] ASC, [_StatementEnd] ASC, [_StatementStart] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_TopQueries_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_TopQueries_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

