CREATE PROCEDURE [data].[AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples]

DELETE [data].[AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Database_IntegrityCheck_StableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION