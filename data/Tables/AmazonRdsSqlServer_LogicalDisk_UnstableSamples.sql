CREATE TABLE [data].[AmazonRdsSqlServer_LogicalDisk_UnstableSamples] (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_CumulativeBytesRead]    BIGINT NULL,
    [_CumulativeBytesWritten] BIGINT NULL,
    [_CumulativeReads]        BIGINT NULL,
    [_CumulativeWrites]       BIGINT NULL,
    CONSTRAINT [AmazonRdsSqlServer_LogicalDisk_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_LogicalDisk_UnstableSamples_AmazonRdsSqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Keys] ([Id]) ON DELETE CASCADE
);

