CREATE TABLE [data].[AmazonRdsSqlServer_Process_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Pid]           BIGINT         NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Process_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Process_Keys_AmazonRdsSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Process_Keys_ParentId__Name__Pid] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC, [_Pid] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Process_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_Process_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

