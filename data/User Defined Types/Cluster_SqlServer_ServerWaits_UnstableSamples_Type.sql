CREATE TYPE [data].[Cluster_SqlServer_ServerWaits_UnstableSamples_Type] AS TABLE (
    [Id]                 BIGINT NOT NULL,
    [CollectionDate]     BIGINT NOT NULL,
    [_SignalWaitTime]    BIGINT NULL,
    [_WaitingTasksCount] BIGINT NULL,
    [_WaitTime]          BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

