CREATE TABLE [data].[AmazonRdsSqlServer_Database_Table_Index_UnstableSamples] (
    [Id]             BIGINT     NOT NULL,
    [CollectionDate] BIGINT     NOT NULL,
    [_Fragmentation] FLOAT (53) NULL,
    [_Pages]         BIGINT     NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_Index_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_Index_UnstableSamples_AmazonRdsSqlServer_Database_Table_Index_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_Table_Index_Keys] ([Id]) ON DELETE CASCADE
);

