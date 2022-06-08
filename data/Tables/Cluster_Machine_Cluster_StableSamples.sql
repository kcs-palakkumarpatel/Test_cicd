﻿CREATE TABLE [data].[Cluster_Machine_Cluster_StableSamples] (
    [Id]             BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    [_State]         BIGINT NULL,
    CONSTRAINT [Cluster_Machine_Cluster_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Machine_Cluster_StableSamples_Cluster_Machine_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Machine_Keys] ([Id]) ON DELETE CASCADE
);

