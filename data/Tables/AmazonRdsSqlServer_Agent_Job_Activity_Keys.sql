CREATE TABLE [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys] (
    [Id]             BIGINT IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_RunDate]       BIGINT NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_Activity_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_Activity_Keys_AmazonRdsSqlServer_Agent_Job_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Agent_Job_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Agent_Job_Activity_Keys_ParentId__RunDate] UNIQUE NONCLUSTERED ([ParentId] ASC, [_RunDate] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Agent_Job_Activity_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_Agent_Job_Activity_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

