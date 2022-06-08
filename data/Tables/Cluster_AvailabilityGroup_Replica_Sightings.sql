﻿CREATE TABLE [data].[Cluster_AvailabilityGroup_Replica_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [Cluster_AvailabilityGroup_Replica_Sightings_Cluster_AvailabilityGroup_Replica_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[Cluster_AvailabilityGroup_Replica_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [Cluster_AvailabilityGroup_Replica_Sightings_Id]
    ON [data].[Cluster_AvailabilityGroup_Replica_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

