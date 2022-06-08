CREATE TYPE [data].[Cluster_Machine_Processors_UnstableSamples_Type] AS TABLE (
    [Id]                                BIGINT     NOT NULL,
    [CollectionDate]                    BIGINT     NOT NULL,
    [_AverageQueueLength]               FLOAT (53) NULL,
    [_CumulativeAverageContextSwitches] BIGINT     NULL,
    [_CumulativeDpcTime]                BIGINT     NULL,
    [_CumulativeIdleTime]               BIGINT     NULL,
    [_CumulativeInterruptTime]          BIGINT     NULL,
    [_CumulativePrivilegedTime]         BIGINT     NULL,
    [_CumulativeUserTime]               BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

