CREATE TABLE [data].[Cluster_Machine_PhysicalProcessors_StableSamples] (
    [Id]                         BIGINT NOT NULL,
    [CollectionDate]             BIGINT NOT NULL,
    [_NumberOfCores]             BIGINT NULL,
    [_NumberOfEnabledCore]       BIGINT NULL,
    [_NumberOfLogicalProcessors] BIGINT NULL,
    CONSTRAINT [Cluster_Machine_PhysicalProcessors_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_PhysicalProcessors_StableSamples_Cluster_Machine_PhysicalProcessors_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_PhysicalProcessors_Keys] ([Id]) ON DELETE CASCADE
);

