CREATE TABLE [data].[AmazonRdsSqlServer_Process_UnstableSamples] (
    [Id]                     BIGINT     NOT NULL,
    [CollectionDate]         BIGINT     NOT NULL,
    [_PercentageCpuUsed]     FLOAT (53) NULL,
    [_PercentageMemoryUsed]  FLOAT (53) NULL,
    [_PrivateSetKilobytes]   BIGINT     NULL,
    [_ShareableSetKilobytes] BIGINT     NULL,
    [_VirtualKilobytes]      BIGINT     NULL,
    CONSTRAINT [AmazonRdsSqlServer_Process_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [AmazonRdsSqlServer_Process_UnstableSamples_AmazonRdsSqlServer_Process_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AmazonRdsSqlServer_Process_Keys] ([Id]) ON DELETE CASCADE
);

