CREATE TABLE [data].[Cluster_Machine_Processors_UnstableSamples] (
    [Id]                                BIGINT     NOT NULL,
    [CollectionDate]                    BIGINT     NOT NULL,
    [_AverageQueueLength]               FLOAT (53) NULL,
    [_CumulativeAverageContextSwitches] BIGINT     NULL,
    [_CumulativeDpcTime]                BIGINT     NULL,
    [_CumulativeIdleTime]               BIGINT     NULL,
    [_CumulativeInterruptTime]          BIGINT     NULL,
    [_CumulativePrivilegedTime]         BIGINT     NULL,
    [_CumulativeUserTime]               BIGINT     NULL,
    CONSTRAINT [Cluster_Machine_Processors_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Processors_UnstableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

