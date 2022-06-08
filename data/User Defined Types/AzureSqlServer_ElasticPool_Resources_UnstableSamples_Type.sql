CREATE TYPE [data].[AzureSqlServer_ElasticPool_Resources_UnstableSamples_Type] AS TABLE (
    [Id]                          BIGINT     NOT NULL,
    [CollectionDate]              BIGINT     NOT NULL,
    [_AvgAllocatedStoragePercent] FLOAT (53) NULL,
    [_AvgCpuPercent]              FLOAT (53) NULL,
    [_AvgDataIoPercent]           FLOAT (53) NULL,
    [_AvgLogWritePercent]         FLOAT (53) NULL,
    [_AvgStoragePercent]          FLOAT (53) NULL,
    [_EndTime]                    BIGINT     NULL,
    [_MaxSessionPercent]          FLOAT (53) NULL,
    [_MaxWorkerPercent]           FLOAT (53) NULL,
    [_StartTime]                  BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

