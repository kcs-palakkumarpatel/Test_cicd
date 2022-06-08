CREATE TABLE [data].[Cluster_SqlServer_Process_UnstableSamples] (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativePrivilegedTime] BIGINT NULL,
    [_CumulativeUserTime]       BIGINT NULL,
    [_PrivateBytes]             BIGINT NULL,
    [_VirtualBytes]             BIGINT NULL,
    [_WorkingSet]               BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Process_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Process_UnstableSamples_Cluster_SqlServer_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Keys] ([Id]) ON DELETE CASCADE
);

