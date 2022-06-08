CREATE TYPE [data].[Cluster_SqlServer_Database_File_UnstableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_Size]          BIGINT NULL,
    [_UsedSize]      BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

