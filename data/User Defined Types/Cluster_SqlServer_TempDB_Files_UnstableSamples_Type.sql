CREATE TYPE [data].[Cluster_SqlServer_TempDB_Files_UnstableSamples_Type] AS TABLE (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_FreeBytes]         BIGINT NULL,
    [_InternalBytes]     BIGINT NULL,
    [_MixedBytes]        BIGINT NULL,
    [_UserBytes]         BIGINT NULL,
    [_VersionStoreBytes] BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

