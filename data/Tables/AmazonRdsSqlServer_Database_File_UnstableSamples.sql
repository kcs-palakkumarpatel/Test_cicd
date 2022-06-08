CREATE TABLE [data].[AmazonRdsSqlServer_Database_File_UnstableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Size]          BIGINT NULL,
    [_UsedSize]      BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_File_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_File_UnstableSamples_AmazonRdsSqlServer_Database_File_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_File_Keys] ([Id]) ON DELETE CASCADE
);

