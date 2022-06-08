CREATE TABLE [data].[AmazonRdsSqlServer_SqlProcess_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_LoginTime]     BIGINT NOT NULL,
    [_SessionId]     BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_Keys_AmazonRdsSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_SqlProcess_Keys_ParentId__LoginTime__SessionId] UNIQUE NONCLUSTERED ([ParentId] ASC, [_LoginTime] ASC, [_SessionId] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_SqlProcess_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_SqlProcess_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

