CREATE PROCEDURE [data].[AzureSqlServer_ElasticPool_Resources_UnstableSamples_DeleteChunk]
    @ChunkSize AS INT
AS
BEGIN TRANSACTION

DECLARE @Chunk TABLE
(
    [Id] BIGINT NOT NULL,
    [CollectionDate] BIGINT NOT NULL,
    PRIMARY KEY ([Id], [CollectionDate])
)

DELETE TOP (@ChunkSize) [#AzureSqlServer_ElasticPool_Resources_UnstableSamples]
OUTPUT deleted.[Id], deleted.[CollectionDate] INTO @Chunk
FROM [#AzureSqlServer_ElasticPool_Resources_UnstableSamples]

DELETE [data].[AzureSqlServer_ElasticPool_Resources_UnstableSamples]
FROM @Chunk c
INNER JOIN [data].[AzureSqlServer_ElasticPool_Resources_UnstableSamples] d ON c.[Id] = d.[Id] AND c.[CollectionDate] = d.[CollectionDate]

COMMIT TRANSACTION