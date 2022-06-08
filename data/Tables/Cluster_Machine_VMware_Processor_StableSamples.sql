﻿CREATE TABLE [data].[Cluster_Machine_VMware_Processor_StableSamples] (
    [Id]                     BIGINT NOT NULL,
    [CollectionDate]         BIGINT NOT NULL,
    [_CpuLimitMhz]           BIGINT NULL,
    [_CpuReservationMhz]     BIGINT NULL,
    [_CpuShares]             BIGINT NULL,
    [_HostProcessorSpeedMhz] BIGINT NULL,
    CONSTRAINT [Cluster_Machine_VMware_Processor_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_VMware_Processor_StableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

