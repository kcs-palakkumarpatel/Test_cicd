CREATE TABLE [data].[Cluster_SqlServer_Database_StableSamples] (
    [Id]                    BIGINT         NOT NULL,
    [CollectionDate]        BIGINT         NOT NULL,
    [_AutoCreateStatistics] BIT            NULL,
    [_AutoShrink]           BIT            NULL,
    [_Collation]            NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_CompatibilityLevel]   BIGINT         NULL,
    [_CreateDate]           BIGINT         NULL,
    [_DatabaseId]           BIGINT         NULL,
    [_Owner]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_PageVerify]           NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_ReadOnly]             BIT            NULL,
    [_RecoveryModel]        NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    [_Standby]              BIT            NULL,
    [_State]                NVARCHAR (MAX) COLLATE Latin1_General_BIN2 NULL,
    CONSTRAINT [Cluster_SqlServer_Database_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_StableSamples_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

