CREATE PROCEDURE [data].[AmazonRdsSqlServer_TopQueries_StableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AmazonRdsSqlServer_TopQueries_StableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AmazonRdsSqlServer_TopQueries_StableSamples]

DELETE [data].[AmazonRdsSqlServer_TopQueries_StableSamples]
FROM @Chunk c
INNER JOIN [data].[AmazonRdsSqlServer_TopQueries_StableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION