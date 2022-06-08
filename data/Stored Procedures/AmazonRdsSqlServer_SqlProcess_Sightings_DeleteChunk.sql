CREATE PROCEDURE [data].[AmazonRdsSqlServer_SqlProcess_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_SqlProcess_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_SqlProcess_Sightings]

DELETE [data].[AmazonRdsSqlServer_SqlProcess_Sightings]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_SqlProcess_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION