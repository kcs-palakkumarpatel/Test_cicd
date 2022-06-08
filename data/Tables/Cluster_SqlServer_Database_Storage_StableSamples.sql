﻿CREATE TABLE [data].[Cluster_SqlServer_Database_Storage_StableSamples] (
    [Id]                  BIGINT NOT NULL,
    [CollectionDate]      BIGINT NOT NULL,
    [_TotalDataSizeBytes] BIGINT NULL,
    [_TotalLogSizeBytes]  BIGINT NULL,
    CONSTRAINT [Cluster_SqlServer_Database_Storage_StableSamples_Id_CollectionDate] PRIMARY KEY CLUSTERED ([Id] ASC, [CollectionDate] ASC) WITH (DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_SqlServer_Database_Storage_StableSamples_Cluster_SqlServer_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_SqlServer_Database_Keys] ([Id]) ON DELETE CASCADE
);

