CREATE TABLE [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_WaitType]      NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys_AmazonRdsSqlServer_TopQueries_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_TopQueries_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys_ParentId__WaitType] UNIQUE NONCLUSTERED ([ParentId] ASC, [_WaitType] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_TopQueries_QueryWaitStats_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

