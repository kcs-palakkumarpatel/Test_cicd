CREATE TABLE [data].[AmazonRdsSqlServer_Error_Keys] (
    [Id]              BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]        BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_LogDate]        BIGINT NOT NULL,
    [_SequenceNumber] BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Error_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Error_Keys_AmazonRdsSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Error_Keys_ParentId__LogDate__SequenceNumber] UNIQUE NONCLUSTERED ([ParentId] ASC, [_LogDate] ASC, [_SequenceNumber] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Error_Keys__LogDate]
    ON [data].[AmazonRdsSqlServer_Error_Keys]([_LogDate] ASC) WITH (DATA_COMPRESSION = PAGE);

