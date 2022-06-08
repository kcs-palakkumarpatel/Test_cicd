CREATE TYPE [data].[AmazonRdsSqlServer_Process_UnstableSamples_Type] AS TABLE (
    [Id]                     BIGINT     NOT NULL,
    [CollectionDate]         BIGINT     NOT NULL,
    [_PercentageCpuUsed]     FLOAT (53) NULL,
    [_PercentageMemoryUsed]  FLOAT (53) NULL,
    [_PrivateSetKilobytes]   BIGINT     NULL,
    [_ShareableSetKilobytes] BIGINT     NULL,
    [_VirtualKilobytes]      BIGINT     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

