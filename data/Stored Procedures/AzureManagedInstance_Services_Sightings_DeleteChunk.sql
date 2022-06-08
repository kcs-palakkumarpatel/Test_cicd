﻿CREATE PROCEDURE [data].[AzureManagedInstance_Services_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AzureManagedInstance_Services_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AzureManagedInstance_Services_Sightings]

DELETE [data].[AzureManagedInstance_Services_Sightings]
FROM @Chunk c
INNER JOIN [data].[AzureManagedInstance_Services_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION