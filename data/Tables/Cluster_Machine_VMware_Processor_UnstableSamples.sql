﻿CREATE TABLE [data].[Cluster_Machine_VMware_Processor_UnstableSamples] (
    [Id]                   BIGINT NOT NULL,
    [CollectionDate]       BIGINT NOT NULL,
    [_EffectiveVmSpeedMhz] BIGINT NULL,
    CONSTRAINT [Cluster_Machine_VMware_Processor_UnstableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_VMware_Processor_UnstableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

