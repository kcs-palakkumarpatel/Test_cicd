CREATE TYPE [data].[AmazonRdsSqlServer_TempDB_Distribution_UnstableSamples_Type] AS TABLE (
    [Id]                BIGINT NOT NULL,
    [CollectionDate]    BIGINT NOT NULL,
    [_FreeBytes]        BIGINT NULL,
    [_InternalBytes]    BIGINT NULL,
    [_MixedExtentBytes] BIGINT NULL,
    [_UserObjectBytes]  BIGINT NULL,
    [_VersionBytes]     BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

