CREATE TYPE [data].[Cluster_SqlServer_Process_UnstableSamples_Type] AS TABLE (
    [Id]                        BIGINT NOT NULL,
    [CollectionDate]            BIGINT NOT NULL,
    [_CumulativePrivilegedTime] BIGINT NULL,
    [_CumulativeUserTime]       BIGINT NULL,
    [_PrivateBytes]             BIGINT NULL,
    [_VirtualBytes]             BIGINT NULL,
    [_WorkingSet]               BIGINT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

