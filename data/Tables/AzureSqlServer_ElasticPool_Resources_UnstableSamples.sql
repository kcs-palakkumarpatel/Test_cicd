CREATE TABLE [data].[AzureSqlServer_ElasticPool_Resources_UnstableSamples] (
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
    CONSTRAINT [AzureSqlServer_ElasticPool_Resources_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_ElasticPool_Resources_UnstableSamples_AzureSqlServer_ElasticPool_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_ElasticPool_Keys] ([Id]) ON DELETE CASCADE
);

