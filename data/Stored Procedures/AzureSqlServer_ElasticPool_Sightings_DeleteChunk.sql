﻿CREATE PROCEDURE [data].[AzureSqlServer_ElasticPool_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AzureSqlServer_ElasticPool_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AzureSqlServer_ElasticPool_Sightings]

DELETE [data].[AzureSqlServer_ElasticPool_Sightings]
FROM @Chunk c
INNER JOIN [data].[AzureSqlServer_ElasticPool_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION