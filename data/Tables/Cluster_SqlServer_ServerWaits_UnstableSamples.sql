CREATE TABLE [data].[Cluster_SqlServer_ServerWaits_UnstableSamples] (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_SignalWaitTime]    BIGINT NULL,
    [_WaitingTasksCount] BIGINT NULL,
    [_WaitTime]          BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_ServerWaits_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_ServerWaits_UnstableSamples_Cluster_SqlServer_ServerWaits_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_ServerWaits_Keys] ([Id]) ON DELETE CASCADE
);

