CREATE TABLE [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Id]            NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    [_Type]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Encryption_Key_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Encryption_Key_Keys_AmazonRdsSqlServer_Database_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Database_Encryption_Key_Keys_ParentId__Id__Type] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Id] ASC, [_Type] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Database_Encryption_Key_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_Database_Encryption_Key_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

