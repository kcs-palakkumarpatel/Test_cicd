CREATE TYPE [data].[AzureSqlServer_Database_Resources_UnstableSamples_Type] AS TABLE (
    [Id]                 BIGINT     NOT NULL,
    [CollectionDate]     BIGINT     NOT NULL,
    [_MaxSessionPercent] FLOAT (53) NULL,
    [_MaxWorkerPercent]  FLOAT (53) NULL,
    [_PercentCpu]        FLOAT (53) NULL,
    [_PercentIo]         FLOAT (53) NULL,
    [_PercentLogWrite]   FLOAT (53) NULL,
    [_PercentMemoryUsed] FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

