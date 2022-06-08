CREATE TABLE [data].[AmazonRdsSqlServer_Database_Table_Index_Keys] (
    [Id]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [ParentId]       BIGINT         NOT NULL,
    [CollectionDate] BIGINT         NOT NULL,
    [_Name]          NVARCHAR (450) COLLATE Latin1_General_BIN2 NOT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_Index_Keys_Id] PRIMARY KEY CLUSTERED ([Id] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_Index_Keys_AmazonRdsSqlServer_Database_Table_Keys] FOREIGN KEY ([ParentId]) REFERENCES [data].[AmazonRdsSqlServer_Database_Table_Keys] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_Index_Keys_ParentId__Name] UNIQUE NONCLUSTERED ([ParentId] ASC, [_Name] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [AmazonRdsSqlServer_Database_Table_Index_Keys_CollectionDate]
    ON [data].[AmazonRdsSqlServer_Database_Table_Index_Keys]([CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE);

