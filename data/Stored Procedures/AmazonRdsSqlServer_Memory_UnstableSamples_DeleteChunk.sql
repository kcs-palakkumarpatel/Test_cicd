CREATE PROCEDURE [data].[AmazonRdsSqlServer_Memory_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_Memory_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AmazonRdsSqlServer_Memory_UnstableSamples]

DELETE [data].[AmazonRdsSqlServer_Memory_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_Memory_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION