CREATE TABLE [data].[Cluster_SqlServer_Database_Table_MissingIndex_UnstableSamples] (
    [Id]              BIGINT     NOT NULL,
    [CollectionDate]  BIGINT     NOT NULL,
    [_AverageCost]    FLOAT (53) NULL,
    [_AverageImpact]  FLOAT (53) NULL,
    [_LastUserScan]   BIGINT     NULL,
    [_LastUserSeek]   BIGINT     NULL,
    [_UniqueCompiles] BIGINT     NULL,
    [_UserScans]      BIGINT     NULL,
    [_UserSeeks]      BIGINT     NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Table_MissingIndex_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Table_MissingIndex_UnstableSamples_Cluster_SqlServer_Database_Table_MissingIndex_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Table_MissingIndex_Keys] ([Id]) ON DELETE CASCADE
);

