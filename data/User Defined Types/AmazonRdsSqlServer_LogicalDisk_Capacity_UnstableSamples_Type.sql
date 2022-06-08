CREATE TYPE [data].[AmazonRdsSqlServer_LogicalDisk_Capacity_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_UsedBytes]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

