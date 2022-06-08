CREATE TABLE [data].[Cluster_SqlServer_Database_Table_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Schema]        NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Table_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Table_Keys_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [Cluster_SqlServer_Database_Table_Keys_ParentId__Name__Schema] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC, [_Schema] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [Cluster_SqlServer_Database_Table_Keys_CollectionDate]
    ON [data].[Cluster_SqlServer_Database_Table_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

