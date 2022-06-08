CREATE TYPE [data].[Cluster_SqlServer_Database_Table_MissingIndex_UnstableSamples_Type] AS TABLE (
    [Id]              BIGINT     NOT NULL,
    [CollectionDate]  BIGINT     NOT NULL,
    [_AverageCost]    FLOAT (53) NULL,
    [_AverageImpact]  FLOAT (53) NULL,
    [_LastUserScan]   BIGINT     NULL,
    [_LastUserSeek]   BIGINT     NULL,
    [_UniqueCompiles] BIGINT     NULL,
    [_UserScans]      BIGINT     NULL,
    [_UserSeeks]      BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

