CREATE TYPE [data].[AmazonRdsSqlServer_LogicalDisk_UnstableSamples_Type] AS TABLE (
    [Id]                      BIGINT NOT NULL,
    [CollectionDate]          BIGINT NOT NULL,
    [_CumulativeBytesRead]    BIGINT NULL,
    [_CumulativeBytesWritten] BIGINT NULL,
    [_CumulativeReads]        BIGINT NULL,
    [_CumulativeWrites]       BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

