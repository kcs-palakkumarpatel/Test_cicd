﻿CREATE TABLE [data].[AzureSqlServer_ElasticPool_Database_Sightings] (
    [Id]           BIGINT NOT NULL,
    [SightingDate] BIGINT NOT NULL,
    CONSTRAINT [AzureSqlServer_ElasticPool_Database_Sightings_SightingDate_Id] PRIMARY KEY CLUSTERED ([SightingDate] ASC, [Id] ASC) WITH (IGNORE_DUP_KEY = ON, DATA_COMPRESSION = PAGE),
    CONSTRAINT [AzureSqlServer_ElasticPool_Database_Sightings_AzureSqlServer_ElasticPool_Database_Keys] FOREIGN KEY ([Id]) REFERENCES [data].[AzureSqlServer_ElasticPool_Database_Keys] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [AzureSqlServer_ElasticPool_Database_Sightings_Id]
    ON [data].[AzureSqlServer_ElasticPool_Database_Sightings]([Id] ASC, [SightingDate] ASC) WITH (DATA_COMPRESSION = PAGE);

