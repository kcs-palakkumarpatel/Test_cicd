﻿CREATE TABLE [data].[Cluster_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [Cluster_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_Sightings_Cluster_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [Cluster_Sightings_Id]
    ON [data].[Cluster_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

