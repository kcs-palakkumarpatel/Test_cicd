CREATE TABLE [data].[AmazonRdsSqlServer_Trace_Keys] (
    [Id]              BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]        BIGINT NOT NULL,
    [CollectionDate]  BIGINT NOT NULL,
    [_SequenceNumber] BIGINT NOT NULL,
    [_StartTime]      BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Trace_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Trace_Keys_AmazonRdsSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Trace_Keys_ParentId__StartTime__SequenceNumber] UNIQUE NONCLUSTERED ([ParentId] ASC, [_StartTime] ASC, [_SequenceNumber] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Trace_Keys__StartTime]
    ON [data].[AmazonRdsSqlServer_Trace_Keys]([_StartTime] ASC) WITH (DATA_COMPRESSION = PAGE);

