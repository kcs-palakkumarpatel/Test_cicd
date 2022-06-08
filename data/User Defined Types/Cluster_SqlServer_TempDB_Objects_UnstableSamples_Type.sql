CREATE TYPE [data].[Cluster_SqlServer_TempDB_Objects_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_ReservedBytes] BIGINT NULL,
    [_RowCount]      BIGINT NULL,
    [_UsedBytes]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

