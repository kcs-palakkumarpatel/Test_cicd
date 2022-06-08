CREATE TABLE [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples] (
    [Id]              BIGINT     NOT NULL,
    [CollectionDate]  BIGINT     NOT NULL,
    [_AverageCost]    FLOAT (53) NULL,
    [_AverageImpact]  FLOAT (53) NULL,
    [_LastUserScan]   BIGINT     NULL,
    [_LastUserSeek]   BIGINT     NULL,
    [_UniqueCompiles] BIGINT     NULL,
    [_UserScans]      BIGINT     NULL,
    [_UserSeeks]      BIGINT     NULL,
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Database_Table_MissingIndex_UnstableSamples_AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Database_Table_MissingIndex_Keys] ([Id]) ON DELETE CASCADE
);

