CREATE TYPE [data].[Cluster_Machine_LogicalDisk_Projection_UnstableSamples_Type] AS TABLE (
    [Id]                 BIGINT     NOT NULL,
    [CollectionDate]     BIGINT     NOT NULL,
    [_EstimatedFullDate] BIGINT     NULL,
    [_SizeInOneYear]     FLOAT (53) NULL,
    [_SizeNow]           FLOAT (53) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC));

