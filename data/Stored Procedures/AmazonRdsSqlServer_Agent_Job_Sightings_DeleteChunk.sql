﻿CREATE PROCEDURE [data].[AmazonRdsSqlServer_Agent_Job_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Agent_Job_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_Agent_Job_Sightings]

DELETE [data].[AmazonRdsSqlServer_Agent_Job_Sightings]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Agent_Job_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION