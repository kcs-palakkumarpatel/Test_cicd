CREATE TYPE [data].[Cluster_SqlServer_Database_Table_StableSamples_Type] AS TABLE (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_CreateDate]    BIGINT NULL,
    [_ModifyDate]    BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

