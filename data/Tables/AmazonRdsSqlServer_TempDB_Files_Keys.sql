CREATE TABLE [data].[AmazonRdsSqlServer_TempDB_Files_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_FileName]      NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Files_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Files_Keys_AmazonRdsSqlServer_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_TempDB_Files_Keys_ParentId__FileName] UNIQUE NONCLUSTERED ([ParentId] ASC, [_FileName] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_TempDB_Files_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_TempDB_Files_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

