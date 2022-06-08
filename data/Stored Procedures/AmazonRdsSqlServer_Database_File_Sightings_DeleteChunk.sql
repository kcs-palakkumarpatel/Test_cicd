CREATE PROCEDURE [data].[AmazonRdsSqlServer_Database_File_Sightings_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [SightingDate] BIGINT NOT NULL,
    [Id] BIGINT NOT NULL,
    PRIMARY KEY ([SightingDate], [Id])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Database_File_Sightings]
OUTPUT deleted.[SightingDate], deleted.[Id] INTO @Chunk
FROM [#AmazonRdsSqlServer_Database_File_Sightings]

DELETE [data].[AmazonRdsSqlServer_Database_File_Sightings]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Database_File_Sightings] d ON c.[SightingDate] = d.[SightingDate] AND c.[Id] = d.[Id]

COMMIT TRANSACTION