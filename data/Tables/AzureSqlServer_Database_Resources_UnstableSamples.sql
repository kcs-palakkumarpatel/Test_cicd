CREATE TABLE [data].[AzureSqlServer_Database_Resources_UnstableSamples] (
    [Id]                 BIGINT     NOT NULL,
    [CollectionDate]     BIGINT     NOT NULL,
    [_MaxSessionPercent] FLOAT (53) NULL,
    [_MaxWorkerPercent]  FLOAT (53) NULL,
    [_PercentCpu]        FLOAT (53) NULL,
    [_PercentIo]         FLOAT (53) NULL,
    [_PercentLogWrite]   FLOAT (53) NULL,
    [_PercentMemoryUsed] FLOAT (53) NULL,
    CONSTRAINT [AzureSqlServer_Database_Resources_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_Database_Resources_UnstableSamples_AzureSqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

